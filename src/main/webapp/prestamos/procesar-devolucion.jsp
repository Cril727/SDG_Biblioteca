<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<%
  // Obtener instancia del manager
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

// Obtener parámetros
  int prestamoId = 0;
  String mensaje = "";
  String tipoMensaje = "";

  try {
    prestamoId = Integer.parseInt(request.getParameter("prestamoId"));
    String estadoLibro = request.getParameter("estadoLibro");
    String observaciones = request.getParameter("observacionesDevolucion");

    // Registrar la devolución
    boolean devuelto = prestamosManager.devolverPrestamo(prestamoId, new Date());

    if (devuelto) {
      // Actualizar observaciones
      Prestamo prestamo = prestamosManager.buscarPrestamoPorId(prestamoId);
      if (prestamo != null) {
        String observacionesFinales = "Estado de devolución: " + estadoLibro;
        if (observaciones != null && !observaciones.isEmpty()) {
          observacionesFinales += ". " + observaciones;
        }
        prestamo.setObservaciones(observacionesFinales);
      }

      mensaje = "Devolución registrada correctamente";
      tipoMensaje = "success";
    } else {
      mensaje = "No se pudo procesar la devolución";
      tipoMensaje = "warning";
    }
  } catch (Exception e) {
    mensaje = "Error al procesar la devolución: " + e.getMessage();
    tipoMensaje = "danger";
  }

// Guardar mensaje en sesión para mostrarlo en la página de listado
  session.setAttribute("mensaje", mensaje);
  session.setAttribute("tipoMensaje", tipoMensaje);

// Redireccionar a la página de listado
  response.sendRedirect("listar.jsp");
%>