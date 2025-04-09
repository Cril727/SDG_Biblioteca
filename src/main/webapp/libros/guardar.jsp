<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<%
  // Obtener instancia del manager
  LibroManager libroManager = LibroManager.getInstance();

  // Obtener acción a realizar
  String accion = request.getParameter("accion");
  String mensaje = "";
  String tipoMensaje = "";

  if (accion != null) {
    if (accion.equals("agregar")) {
      // Lógica para agregar libro
      try {
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String isbn = request.getParameter("isbn");
        String editorial = request.getParameter("editorial");
        int anioPublicacion = Integer.parseInt(request.getParameter("anioPublicacion"));
        String descripcion = request.getParameter("descripcion");
        String tipoLibro = request.getParameter("tipoLibro");

        Libro nuevoLibro = null;

        if (tipoLibro.equals("ficcion")) {
          String genero = request.getParameter("genero");
          int premios = Integer.parseInt(request.getParameter("premios") != null && !request.getParameter("premios").isEmpty() ? request.getParameter("premios") : "0");
          nuevoLibro = new LibroFiccion(titulo, autor, isbn, genero, premios);
        } else if (tipoLibro.equals("noficcion")) {
          String areaTematica = request.getParameter("areaTematica");
          String publicoObjetivo = request.getParameter("publicoObjetivo");
          nuevoLibro = new LibroNoFiccion(titulo, autor, isbn, areaTematica, publicoObjetivo);
        } else if (tipoLibro.equals("referencia")) {
          String campoAcademico = request.getParameter("campoAcademico");
          boolean soloConsulta = "consulta".equals(request.getParameter("tipoPrestamo"));
          nuevoLibro = new LibroReferencia(titulo, autor, isbn, campoAcademico, soloConsulta);
        }

        if (nuevoLibro != null) {
          nuevoLibro.setEditorial(editorial);
          nuevoLibro.setAnioPublicacion(anioPublicacion);
          nuevoLibro.setDescripcion(descripcion);

          libroManager.agregarLibro(nuevoLibro);
          mensaje = "Libro agregado correctamente";
          tipoMensaje = "success";
        }
      } catch (Exception e) {
        mensaje = "Error al agregar libro: " + e.getMessage();
        tipoMensaje = "danger";
      }
    } else if (accion.equals("editar")) {
      // Lógica para editar libro
      try {
        int id = Integer.parseInt(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String isbn = request.getParameter("isbn");
        String editorial = request.getParameter("editorial");
        int anioPublicacion = Integer.parseInt(request.getParameter("anioPublicacion"));
        String descripcion = request.getParameter("descripcion");
        String tipoLibro = request.getParameter("tipoLibro");

        // Obtener el libro existente
        Libro libroExistente = libroManager.buscarLibroPorId(id);

        if (libroExistente != null) {
          // Actualizar propiedades comunes
          libroExistente.setTitulo(titulo);
          libroExistente.setAutor(autor);
          libroExistente.setIsbn(isbn);
          libroExistente.setEditorial(editorial);
          libroExistente.setAnioPublicacion(anioPublicacion);
          libroExistente.setDescripcion(descripcion);

          // Actualizar propiedades específicas según el tipo
          if (tipoLibro.equals("ficcion") && libroExistente instanceof LibroFiccion) {
            LibroFiccion libroFiccion = (LibroFiccion) libroExistente;
            libroFiccion.setGenero(request.getParameter("genero"));
            libroFiccion.setPremios(Integer.parseInt(request.getParameter("premios")));
          } else if (tipoLibro.equals("noficcion") && libroExistente instanceof LibroNoFiccion) {
            LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libroExistente;
            libroNoFiccion.setAreaTematica(request.getParameter("areaTematica"));
            libroNoFiccion.setPublicoObjetivo(request.getParameter("publicoObjetivo"));
          } else if (tipoLibro.equals("referencia") && libroExistente instanceof LibroReferencia) {
            LibroReferencia libroReferencia = (LibroReferencia) libroExistente;
            libroReferencia.setCampoAcademico(request.getParameter("campoAcademico"));
            libroReferencia.setSoloConsulta("consulta".equals(request.getParameter("tipoPrestamo")));
          }

          mensaje = "Libro actualizado correctamente";
          tipoMensaje = "success";
        } else {
          mensaje = "No se encontró el libro a editar";
          tipoMensaje = "warning";
        }
      } catch (Exception e) {
        mensaje = "Error al editar libro: " + e.getMessage();
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