<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<%
  // Obtener instancia del manager
  LibroManager libroManager = LibroManager.getInstance();

  // Obtener el ID del libro a eliminar
  int libroId = 0;
  try {
    libroId = Integer.parseInt(request.getParameter("id"));
  } catch (NumberFormatException e) {
    // Redirigir si no hay ID válido
    session.setAttribute("mensaje", "ID de libro inválido");
    session.setAttribute("tipoMensaje", "danger");
    response.sendRedirect("listar.jsp");
    return;
  }

  // Eliminar el libro
  boolean eliminado = libroManager.eliminarLibroPorId(libroId);

  if (eliminado) {
    session.setAttribute("mensaje", "Libro eliminado correctamente");
    session.setAttribute("tipoMensaje", "success");
  } else {
    session.setAttribute("mensaje", "No se pudo eliminar el libro. Puede estar prestado o no existir.");
    session.setAttribute("tipoMensaje", "warning");
  }

  // Redireccionar a la página de listado
  response.sendRedirect("listar.jsp");
%>