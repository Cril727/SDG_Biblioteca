<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<%

  LibroManager libroManager = LibroManager.getInstance();


  int libroId = 0;
  try {
    libroId = Integer.parseInt(request.getParameter("id"));
  } catch (NumberFormatException e) {

    session.setAttribute("mensaje", "ID de libro inválido");
    session.setAttribute("tipoMensaje", "danger");
    response.sendRedirect("listar.jsp");
    return;
  }


  boolean eliminado = libroManager.eliminarLibroPorId(libroId);

  if (eliminado) {
    session.setAttribute("mensaje", "Libro eliminado correctamente");
    session.setAttribute("tipoMensaje", "success");
  } else {
    session.setAttribute("mensaje", "No se pudo eliminar el libro. Puede estar prestado o no existir.");
    session.setAttribute("tipoMensaje", "warning");
  }


  response.sendRedirect("listar.jsp");
%>