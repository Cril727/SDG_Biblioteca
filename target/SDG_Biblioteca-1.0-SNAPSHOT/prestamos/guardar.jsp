<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.text.SimpleDateFormat, cris.julian.sdg_biblioteca.model.*"%>
<%

  LibroManager libroManager = LibroManager.getInstance();
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

  String accion = request.getParameter("accion");
  String mensaje = "";
  String tipoMensaje = "";

  if (accion != null) {
    if (accion.equals("registrar")) {

      try {
        int libroId = Integer.parseInt(request.getParameter("libroId"));
        String nombrePrestador = request.getParameter("usuarioId");
        String observaciones = request.getParameter("observaciones");


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaPrestamo = sdf.parse(request.getParameter("fechaPrestamo"));
        Date fechaDevolucion = sdf.parse(request.getParameter("fechaDevolucion"));


        if (fechaDevolucion.before(fechaPrestamo)) {
          mensaje = "La fecha de devolución debe ser posterior a la fecha de préstamo";
          tipoMensaje = "warning";
        } else {

          Libro libro = libroManager.buscarLibroPorId(libroId);

          if (libro != null) {

            if (!libro.isPrestado() && !(libro instanceof LibroReferencia && ((LibroReferencia) libro).isSoloConsulta())) {

              boolean prestado = prestamosManager.crearPrestamo(libro, nombrePrestador, fechaPrestamo, fechaDevolucion);

              if (prestado) {
                mensaje = "Préstamo registrado correctamente";
                tipoMensaje = "success";
              } else {
                mensaje = "No se pudo registrar el préstamo";
                tipoMensaje = "danger";
              }
            } else {
              mensaje = "El libro no está disponible para préstamo";
              tipoMensaje = "warning";
            }
          } else {
            mensaje = "No se encontró el libro solicitado";
            tipoMensaje = "danger";
          }
        }
      } catch (Exception e) {
        mensaje = "Error al registrar préstamo: " + e.getMessage();
        tipoMensaje = "danger";
      }
    }
  }


  session.setAttribute("mensaje", mensaje);
  session.setAttribute("tipoMensaje", tipoMensaje);


  response.sendRedirect("listar.jsp");
%>