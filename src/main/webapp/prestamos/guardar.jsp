<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.text.SimpleDateFormat, cris.julian.sdg_biblioteca.model.*"%>
<%
  // Obtener instancias de los managers
  LibroManager libroManager = LibroManager.getInstance();
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

  // Obtener acción a realizar
  String accion = request.getParameter("accion");
  String mensaje = "";
  String tipoMensaje = "";

  if (accion != null) {
    if (accion.equals("registrar")) {
      // Lógica para registrar préstamo
      try {
        int libroId = Integer.parseInt(request.getParameter("libroId"));
        String nombrePrestador = request.getParameter("usuarioId");
        String observaciones = request.getParameter("observaciones");

        // Obtener fechas
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaPrestamo = sdf.parse(request.getParameter("fechaPrestamo"));
        Date fechaDevolucion = sdf.parse(request.getParameter("fechaDevolucion"));

        // Validar que la fecha de devolución sea posterior a la de préstamo
        if (fechaDevolucion.before(fechaPrestamo)) {
          mensaje = "La fecha de devolución debe ser posterior a la fecha de préstamo";
          tipoMensaje = "warning";
        } else {
          // Buscar el libro
          Libro libro = libroManager.buscarLibroPorId(libroId);

          if (libro != null) {
            // Verificar si el libro está disponible
            if (!libro.isPrestado() && !(libro instanceof LibroReferencia && ((LibroReferencia) libro).isSoloConsulta())) {
              // Registrar el préstamo
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

  // Guardar mensaje en sesión para mostrarlo en la página de listado
  session.setAttribute("mensaje", mensaje);
  session.setAttribute("tipoMensaje", tipoMensaje);

  // Redireccionar a la página de listado
  response.sendRedirect("listar.jsp");
%>