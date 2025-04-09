<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sistema de Gestión de Biblioteca Municipal</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="css/styles.css">
  <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
</head>
<body>
<%
  // Obtener instancias de los managers
  LibroManager libroManager = LibroManager.getInstance();
  prestamoManager prestamosManager = prestamoManager.getInstance();

  // Inicializar con algunos datos si está vacío
  if (libroManager.listarLibros().isEmpty()) {
    // Usar los datos de Inventario para inicializar
    for (Libro libro : Inventario.getLibroList()) {
      libroManager.agregarLibro(libro);
    }
  }

  // Procesar acciones
  String accion = request.getParameter("accion");
  String mensaje = "";
  String tipoMensaje = "";

  if (accion != null) {
    if (accion.equals("agregarLibro")) {
      // Lógica para agregar libro
      try {
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String isbn = request.getParameter("isbn");
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
          libroManager.agregarLibro(nuevoLibro);
          mensaje = "Libro agregado correctamente";
          tipoMensaje = "success";
        }
      } catch (Exception e) {
        mensaje = "Error al agregar libro: " + e.getMessage();
        tipoMensaje = "danger";
      }
    } else if (accion.equals("eliminarLibro")) {
      // Lógica para eliminar libro
      try {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean eliminado = libroManager.eliminarLibroPorId(id);
        if (eliminado) {
          mensaje = "Libro eliminado correctamente";
          tipoMensaje = "success";
        } else {
          mensaje = "No se pudo encontrar el libro";
          tipoMensaje = "warning";
        }
      } catch (Exception e) {
        mensaje = "Error al eliminar libro: " + e.getMessage();
        tipoMensaje = "danger";
      }
    } else if (accion.equals("registrarPrestamo")) {
      // Lógica para registrar préstamo
      try {
        int libroId = Integer.parseInt(request.getParameter("libroId"));
        String nombrePrestador = request.getParameter("usuarioId");
        Date fechaPrestamo = new Date(); // Fecha actual

        // Convertir string a Date para la fecha de devolución
        String fechaDevolucionStr = request.getParameter("fechaDevolucion");
        Date fechaDevolucion = new Date(fechaPrestamo.getTime() + (14 * 24 * 60 * 60 * 1000)); // Por defecto 14 días

        Libro libro = libroManager.buscarLibroPorId(libroId);
        if (libro != null) {
          boolean prestado = prestamosManager.crearPrestamo(libro, nombrePrestador, fechaPrestamo, fechaDevolucion);
          if (prestado) {
            mensaje = "Préstamo registrado correctamente";
            tipoMensaje = "success";
          } else {
            mensaje = "El libro ya está prestado";
            tipoMensaje = "warning";
          }
        } else {
          mensaje = "No se encontró el libro";
          tipoMensaje = "warning";
        }
      } catch (Exception e) {
        mensaje = "Error al registrar préstamo: " + e.getMessage();
        tipoMensaje = "danger";
      }
    } else if (accion.equals("devolverLibro")) {
      // Lógica para devolver libro
      try {
        int libroId = Integer.parseInt(request.getParameter("libroId"));
        Date fechaDevolucion = new Date(); // Fecha actual

        boolean devuelto = prestamosManager.devolverPrestamo(libroId, fechaDevolucion);
        if (devuelto) {
          mensaje = "Libro devuelto correctamente";
          tipoMensaje = "success";
        } else {
          mensaje = "No se pudo procesar la devolución";
          tipoMensaje = "warning";
        }
      } catch (Exception e) {
        mensaje = "Error al devolver libro: " + e.getMessage();
        tipoMensaje = "danger";
      }
    }
  }

  // Obtener listas para mostrar en la página
  List<Libro> libros = libroManager.listarLibros();
  List<Prestamo> prestamosActivos = prestamosManager.listarPrestamosActivos();
  List<Prestamo> prestamosDevueltos = prestamosManager.listarPrestamosDevueltos();

  // Contar libros por categoría
  int contadorFiccion = 0;
  int contadorNoFiccion = 0;
  int contadorReferencia = 0;

  for (Libro libro : libros) {
    if (libro instanceof LibroFiccion) {
      contadorFiccion++;
    } else if (libro instanceof LibroNoFiccion) {
      contadorNoFiccion++;
    } else if (libro instanceof LibroReferencia) {
      contadorReferencia++;
    }
  }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-library">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="#">
      <i class="bi bi-book me-2"></i>
      <span>BiblioTech</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#catalogo">Catálogo</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#prestamos">Préstamos</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Toast para mensajes -->
<% if (!mensaje.isEmpty()) { %>
<div class="toast-container">
  <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header bg-<%= tipoMensaje %> text-white">
      <strong class="me-auto">Notificación</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      <%= mensaje %>
    </div>
  </div>
</div>
<% } %>

<!-- Carousel -->
<div id="carouselLibros" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselLibros" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#carouselLibros" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#carouselLibros" data-bs-slide-to="2"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66" class="d-block w-100" alt="Libros de ficción">
      <div class="carousel-caption d-none d-md-block">
        <h2>Biblioteca Municipal de Duitama</h2>
        <p>Explora nuestra colección de libros</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f" class="d-block w-100" alt="Libros de no ficción">
      <div class="carousel-caption d-none d-md-block">
        <h2>Nuevas Adquisiciones</h2>
        <p>Descubre los últimos títulos añadidos a nuestra colección</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="https://images.unsplash.com/photo-1481627834876-b7833e8f5570" class="d-block w-100" alt="Libros de referencia">
      <div class="carousel-caption d-none d-md-block">
        <h2>Préstamos Digitales</h2>
        <p>Accede a nuestra biblioteca digital desde cualquier lugar</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselLibros" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Anterior</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselLibros" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Siguiente</span>
  </button>
</div>

<!-- Quick Actions -->
<section class="py-5">
  <div class="container d-flex flex-column align-items-center text-center">
    <h2 class="text-center mb-4">Acciones Rápidas</h2>
    <div class="row justify-content-center g-4">
      <div class="col-md-6">
        <div class="card h-100 card-hover">
          <div class="card-body text-center">
            <i class="bi bi-plus-circle text-primary fs-1 mb-3"></i>
            <h5 class="card-title">Agregar Libro</h5>
            <p class="card-text">Registra un nuevo libro en el sistema</p>
            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#agregarLibroModal">
              Agregar
            </button>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card h-100 card-hover">
          <div class="card-body text-center">
            <i class="bi bi-arrow-left-right text-success fs-1 mb-3"></i>
            <h5 class="card-title">Préstamos</h5>
            <p class="card-text">Gestiona préstamos y devoluciones</p>
            <a href="#prestamos" class="btn btn-outline-success">Gestionar</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Book Categories -->
<section class="py-5 bg-light" id="catalogo">
  <div class="container">
    <h2 class="text-center mb-4">Categorías de Libros</h2>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="book-category" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1544947950-fa07a98d237f');">
            <h3>Ficción</h3>
          </div>
          <div class="card-body">
            <p class="card-text">Novelas, cuentos, poesía y otros géneros literarios de ficción.</p>
            <div class="d-flex justify-content-between align-items-center">
              <small class="text-muted"><%= contadorFiccion %> libros</small>
              <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#listaLibrosModal" data-category="ficcion">Ver todos</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="book-category" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8');">
            <h3>No Ficción</h3>
          </div>
          <div class="card-body">
            <p class="card-text">Biografías, historia, ciencia, filosofía y otros textos informativos.</p>
            <div class="d-flex justify-content-between align-items-center">
              <small class="text-muted"><%= contadorNoFiccion %> libros</small>
              <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#listaLibrosModal" data-category="noficcion">Ver todos</button>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="book-category" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1497633762265-9d179a990aa6');">
            <h3>Referencia</h3>
          </div>
          <div class="card-body">
            <p class="card-text">Enciclopedias, diccionarios, manuales y otros libros de consulta.</p>
            <div class="d-flex justify-content-between align-items-center">
              <small class="text-muted"><%= contadorReferencia %> libros</small>
              <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#listaLibrosModal" data-category="referencia">Ver todos</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Book Inventory -->
<section class="py-5" id="inventario">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Inventario de Libros</h2>
      <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#agregarLibroModal">
        <i class="bi bi-plus-lg"></i> Agregar Libro
      </button>
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Título</th>
          <th>Autor</th>
          <th>Categoría</th>
          <th>Estado</th>
          <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% for (Libro libro : libros) { %>
        <tr>
          <td><%= libro.getId() %></td>
          <td><%= libro.getTitulo() %></td>
          <td><%= libro.getAutor() %></td>
          <td>
            <% if (libro instanceof LibroFiccion) { %>
            <span class="badge bg-primary">Ficción</span>
            <% } else if (libro instanceof LibroNoFiccion) { %>
            <span class="badge bg-info">No Ficción</span>
            <% } else if (libro instanceof LibroReferencia) { %>
            <span class="badge bg-warning">Referencia</span>
            <% } else { %>
            <span class="badge bg-secondary">General</span>
            <% } %>
          </td>
          <td>
            <% if (libro.isPrestado()) { %>
            <span class="badge bg-warning text-dark">Prestado</span>
            <% } else if (libro instanceof LibroReferencia && ((LibroReferencia)libro).isSoloConsulta()) { %>
            <span class="badge bg-danger">Solo Consulta</span>
            <% } else { %>
            <span class="badge bg-success">Disponible</span>
            <% } %>
          </td>
          <td>
            <div class="btn-group btn-group-sm">
              <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editarLibroModal"
                      data-id="<%= libro.getId() %>" data-titulo="<%= libro.getTitulo() %>"
                      data-autor="<%= libro.getAutor() %>" data-isbn="<%= libro.getIsbn() %>">
                <i class="bi bi-pencil"></i>
              </button>
              <form action="index.jsp" method="post" style="display:inline;">
                <input type="hidden" name="accion" value="eliminarLibro">
                <input type="hidden" name="id" value="<%= libro.getId() %>">
                <button type="submit" class="btn btn-danger" onclick="return confirm('¿Está seguro de eliminar este libro?')">
                  <i class="bi bi-trash"></i>
                </button>
              </form>
              <% if (!libro.isPrestado() && !(libro instanceof LibroReferencia && ((LibroReferencia)libro).isSoloConsulta())) { %>
              <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#prestamoModal"
                      data-id="<%= libro.getId() %>" data-titulo="<%= libro.getTitulo() %>">
                <i class="bi bi-arrow-right"></i>
              </button>
              <% } else if (libro.isPrestado()) { %>
              <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#devolucionModal"
                      data-id="<%= libro.getId() %>" data-titulo="<%= libro.getTitulo() %>">
                <i class="bi bi-arrow-left"></i>
              </button>
              <% } else { %>
              <button class="btn btn-secondary" disabled>
                <i class="bi bi-arrow-right"></i>
              </button>
              <% } %>
            </div>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</section>

<!-- Loans Section -->
<section class="py-5 bg-light" id="prestamos">
  <div class="container">
    <h2 class="text-center mb-4">Gestión de Préstamos</h2>
    <ul class="nav nav-tabs mb-4" id="prestamosTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="activos-tab" data-bs-toggle="tab" data-bs-target="#activos" type="button" role="tab" aria-controls="activos" aria-selected="true">Préstamos Activos</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="historial-tab" data-bs-toggle="tab" data-bs-target="#historial" type="button" role="tab" aria-controls="historial" aria-selected="false">Historial</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="vencidos-tab" data-bs-toggle="tab" data-bs-target="#vencidos" type="button" role="tab" aria-controls="vencidos" aria-selected="false">Vencidos</button>
      </li>
    </ul>
    <div class="tab-content" id="prestamosTabsContent">
      <div class="tab-pane fade show active" id="activos" role="tabpanel" aria-labelledby="activos-tab">
        <% if (prestamosActivos.isEmpty()) { %>
        <div class="alert alert-info">No hay préstamos activos actualmente.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
            <tr>
              <th>ISBN</th>
              <th>Libro</th>
              <th>Usuario</th>
              <th>Fecha Préstamo</th>
              <th>Fecha Devolución</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Prestamo prestamo : prestamosActivos) { %>
            <tr>
              <td><%= prestamo.getIsbn() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaLimite()) %></td>
              <td>
                <% if (prestamo.isVencido()) { %>
                <span class="badge bg-danger">Vencido</span>
                <% } else { %>
                <span class="badge bg-success">Al día</span>
                <% } %>
              </td>
              <td>
                <form action="index.jsp" method="post">
                  <input type="hidden" name="accion" value="devolverLibro">
                  <input type="hidden" name="libroId" value="<%= prestamo.getLibro().getId() %>">
                  <button type="submit" class="btn btn-sm btn-primary">
                    <i class="bi bi-arrow-return-left"></i> Devolver
                  </button>
                </form>
              </td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
      <div class="tab-pane fade" id="historial" role="tabpanel" aria-labelledby="historial-tab">
        <% if (prestamosDevueltos.isEmpty()) { %>
        <div class="alert alert-info">No hay historial de préstamos.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
            <tr>
              <th>ISBN</th>
              <th>Libro</th>
              <th>Usuario</th>
              <th>Fecha Préstamo</th>
              <th>Fecha Devolución</th>
              <th>Estado</th>
            </tr>
            </thead>
            <tbody>
            <% for (Prestamo prestamo : prestamosDevueltos) { %>
            <tr>
              <td><%= prestamo.getIsbn() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaDevolucion()) %></td>
              <td><span class="badge bg-info">Devuelto</span></td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
      <div class="tab-pane fade" id="vencidos" role="tabpanel" aria-labelledby="vencidos-tab">
        <%
          boolean hayVencidos = false;
          for (Prestamo prestamo : prestamosActivos) {
            if (prestamo.isVencido()) {
              hayVencidos = true;
              break;
            }
          }

          if (!hayVencidos) {
        %>
        <div class="alert alert-success">No hay préstamos vencidos actualmente.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
            <tr>
              <th>ISBN</th>
              <th>Libro</th>
              <th>Usuario</th>
              <th>Fecha Préstamo</th>
              <th>Fecha Límite</th>
              <th>Días de Retraso</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
              for (Prestamo prestamo : prestamosActivos) {
                if (prestamo.isVencido()) {
                  long diff = new Date().getTime() - prestamo.getFechaLimite().getTime();
                  long diasRetraso = diff / (24 * 60 * 60 * 1000);
            %>
            <tr>
              <td><%= prestamo.getIsbn() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaLimite()) %></td>
              <td><span class="badge bg-danger"><%= diasRetraso %> días</span></td>
              <td>
                <form action="index.jsp" method="post">
                  <input type="hidden" name="accion" value="devolverLibro">
                  <input type="hidden" name="libroId" value="<%= prestamo.getLibro().getId() %>">
                  <button type="submit" class="btn btn-sm btn-primary">
                    <i class="bi bi-arrow-return-left"></i> Devolver
                  </button>
                </form>
              </td>
            </tr>
            <%
                }
              }
            %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
    </div>
  </div>
</section>

<!-- Stats Section -->
<section class="py-5 bg-primary text-white">
  <div class="container">
    <div class="row text-center">
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-book fs-1 mb-2"></i>
        <h3 class="h2"><%= libros.size() %></h3>
        <p>Libros en Catálogo</p>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-people fs-1 mb-2"></i>
        <h3 class="h2">
          <%= new HashSet<String>() {{
            for (Prestamo p : prestamosActivos) add(p.getNombrePrestador());
            for (Prestamo p : prestamosDevueltos) add(p.getNombrePrestador());
          }}.size() %>
        </h3>
        <p>Usuarios Activos</p>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-arrow-left-right fs-1 mb-2"></i>
        <h3 class="h2"><%= prestamosActivos.size() %></h3>
        <p>Préstamos Activos</p>
      </div>
      <div class="col-md-3">
        <i class="bi bi-calendar-check fs-1 mb-2"></i>
        <h3 class="h2"><%= prestamosDevueltos.size() %></h3>
        <p>Préstamos Completados</p>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4">
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-4 mb-md-0">
        <h5 class="mb-3">BiblioTech</h5>
        <p class="mb-0">Sistema de gestión para bibliotecas municipales, desarrollado para mejorar la experiencia de usuarios y administradores.</p>
      </div>
      <div class="col-md-2 mb-4 mb-md-0">
        <h5 class="mb-3">Enlaces</h5>
        <ul class="list-unstyled">
          <li><a href="#" class="text-white-50">Inicio</a></li>
          <li><a href="#catalogo" class="text-white-50">Catálogo</a></li>
          <li><a href="#prestamos" class="text-white-50">Préstamos</a></li>
        </ul>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <h5 class="mb-3">Recursos</h5>
        <ul class="list-unstyled">
          <li><a href="#" class="text-white-50">Documentación</a></li>
          <li><a href="#" class="text-white-50">Tutoriales</a></li>
          <li><a href="#" class="text-white-50">Preguntas Frecuentes</a></li>
          <li><a href="#" class="text-white-50">Soporte</a></li>
        </ul>
      </div>
      <div class="col-md-3">
        <h5 class="mb-3">Contacto</h5>
        <ul class="list-unstyled text-white-50">
          <li><i class="bi bi-geo-alt me-2"></i> Biblioteca Municipal de Duitama</li>
          <li><i class="bi bi-building me-2"></i> Calle Principal #123</li>
          <li><i class="bi bi-envelope me-2"></i> contacto@biblioteca.gov.co</li>
          <li><i class="bi bi-telephone me-2"></i> +57 (8) 123-4567</li>
        </ul>
      </div>
    </div>
    <hr class="my-4 bg-light">
    <div class="text-center text-white-50">
      <p class="mb-0">© <%= new java.util.Date().getYear() + 1900 %> Sistema de Gestión de Biblioteca Municipal. Todos los derechos reservados.</p>
    </div>
  </div>
</footer>

<!-- Modals -->
<!-- Agregar Libro Modal -->
<div class="modal fade" id="agregarLibroModal" tabindex="-1" aria-labelledby="agregarLibroModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="agregarLibroModalLabel">Agregar Nuevo Libro</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="agregarLibroForm" action="index.jsp" method="post">
          <input type="hidden" name="accion" value="agregarLibro">
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="titulo" class="form-label">Título</label>
              <input type="text" class="form-control" id="titulo" name="titulo" required>
            </div>
            <div class="col-md-6">
              <label for="autor" class="form-label">Autor</label>
              <input type="text" class="form-control" id="autor" name="autor" required>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-md-4">
              <label for="isbn" class="form-label">ISBN</label>
              <input type="text" class="form-control" id="isbn" name="isbn" required>
            </div>
            <div class="col-md-4">
              <label for="anioPublicacion" class="form-label">Año de Publicación</label>
              <input type="number" class="form-control" id="anioPublicacion" name="anioPublicacion" required>
            </div>
            <div class="col-md-4">
              <label for="editorial" class="form-label">Editorial</label>
              <input type="text" class="form-control" id="editorial" name="editorial" required>
            </div>
          </div>
          <div class="mb-3">
            <label for="tipoLibro" class="form-label">Tipo de Libro</label>
            <select class="form-select" id="tipoLibro" name="tipoLibro" required onchange="mostrarCamposDinamicos()">
              <option value="" selected disabled>Seleccionar tipo...</option>
              <option value="ficcion">Ficción</option>
              <option value="noficcion">No Ficción</option>
              <option value="referencia">Referencia</option>
            </select>
          </div>

          <!-- Campos dinámicos para Ficción -->
          <div id="camposFiccion" class="campos-dinamicos" style="display: none;">
            <div class="row mb-3">
              <div class="col-md-6">
                <label for="genero" class="form-label">Género</label>
                <select class="form-select" id="genero" name="genero">
                  <option value="novela">Novela</option>
                  <option value="cuento">Cuento</option>
                  <option value="poesia">Poesía</option>
                  <option value="teatro">Teatro</option>
                  <option value="otro">Otro</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="premios" class="form-label">Premios Literarios</label>
                <input type="number" class="form-control" id="premios" name="premios" placeholder="Opcional" value="0">
              </div>
            </div>
          </div>

          <!-- Campos dinámicos para No Ficción -->
          <div id="camposNoFiccion" class="campos-dinamicos" style="display: none;">
            <div class="row mb-3">
              <div class="col-md-6">
                <label for="areaTematica" class="form-label">Área Temática</label>
                <select class="form-select" id="areaTematica" name="areaTematica">
                  <option value="historia">Historia</option>
                  <option value="ciencia">Ciencia</option>
                  <option value="biografia">Biografía</option>
                  <option value="autoayuda">Autoayuda</option>
                  <option value="otro">Otro</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
                <select class="form-select" id="publicoObjetivo" name="publicoObjetivo">
                  <option value="general">General</option>
                  <option value="infantil">Infantil</option>
                  <option value="juvenil">Juvenil</option>
                  <option value="academico">Académico</option>
                  <option value="especializado">Especializado</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Campos dinámicos para Referencia -->
          <div id="camposReferencia" class="campos-dinamicos" style="display: none;">
            <div class="row mb-3">
              <div class="col-md-6">
                <label for="campoAcademico" class="form-label">Campo Académico</label>
                <select class="form-select" id="campoAcademico" name="campoAcademico">
                  <option value="linguistica">Lingüística</option>
                  <option value="ciencias">Ciencias</option>
                  <option value="humanidades">Humanidades</option>
                  <option value="tecnologia">Tecnología</option>
                  <option value="otro">Otro</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Tipo de Préstamo</label>
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="tipoPrestamo" id="prestamoNormal" value="normal">
                  <label class="form-check-label" for="prestamoNormal">
                    Préstamo Normal
                  </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="tipoPrestamo" id="soloConsulta" value="consulta" checked>
                  <label class="form-check-label" for="soloConsulta">
                    Solo Consulta en Biblioteca
                  </label>
                </div>
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary">Guardar Libro</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Préstamo Modal -->
<div class="modal fade" id="prestamoModal" tabindex="-1" aria-labelledby="prestamoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="prestamoModalLabel">Registrar Préstamo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="prestamoForm" action="index.jsp" method="post">
          <input type="hidden" name="accion" value="registrarPrestamo">
          <input type="hidden" name="libroId" id="prestamoLibroId">
          <div class="mb-3">
            <label for="libroTitulo" class="form-label">Libro</label>
            <input type="text" class="form-control" id="libroTitulo" readonly>
          </div>
          <div class="mb-3">
            <label for="usuarioId" class="form-label">Usuario</label>
            <select class="form-select" id="usuarioId" name="usuarioId" required>
              <option value="" selected disabled>Seleccionar usuario...</option>
              <option value="María López">María López</option>
              <option value="Carlos Rodríguez">Carlos Rodríguez</option>
              <option value="Ana Martínez">Ana Martínez</option>
              <option value="Juan Pérez">Juan Pérez</option>
            </select>
          </div>
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
              <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" readonly>
            </div>
            <div class="col-md-6">
              <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
              <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis() + (14 * 24 * 60 * 60 * 1000))) %>" required>
            </div>
          </div>
          <div class="mb-3">
            <label for="observaciones" class="form-label">Observaciones</label>
            <textarea class="form-control" id="observaciones" name="observaciones" rows="2"></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-success">Registrar Préstamo</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Devolución Modal -->
<div class="modal fade" id="devolucionModal" tabindex="-1" aria-labelledby="devolucionModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="devolucionModalLabel">Registrar Devolución</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="devolucionForm" action="index.jsp" method="post">
          <input type="hidden" name="accion" value="devolverLibro">
          <input type="hidden" name="libroId" id="devolucionLibroId">
          <div class="mb-3">
            <label for="libroDevolucionTitulo" class="form-label">Libro</label>
            <input type="text" class="form-control" id="libroDevolucionTitulo" readonly>
          </div>
          <div class="mb-3">
            <label for="estadoLibro" class="form-label">Estado del Libro</label>
            <select class="form-select" id="estadoLibro" name="estadoLibro" required>
              <option value="bueno" selected>Bueno</option>
              <option value="regular">Regular</option>
              <option value="malo">Malo</option>
              <option value="dañado">Dañado</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="observacionesDevolucion" class="form-label">Observaciones</label>
            <textarea class="form-control" id="observacionesDevolucion" name="observacionesDevolucion" rows="2"></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary">Registrar Devolución</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript para campos dinámicos y modales -->
<script>
  function mostrarCamposDinamicos() {
    // Ocultar todos los campos dinámicos
    document.querySelectorAll('.campos-dinamicos').forEach(campo => {
      campo.style.display = 'none';
    });

    // Mostrar los campos correspondientes al tipo seleccionado
    const tipoLibro = document.getElementById('tipoLibro').value;
    if (tipoLibro === 'ficcion') {
      document.getElementById('camposFiccion').style.display = 'block';
    } else if (tipoLibro === 'noficcion') {
      document.getElementById('camposNoFiccion').style.display = 'block';
    } else if (tipoLibro === 'referencia') {
      document.getElementById('camposReferencia').style.display = 'block';
    }
  }

  // Inicializar tooltips y popovers de Bootstrap
  document.addEventListener('DOMContentLoaded', function() {
    // Código para actualizar el título del modal de lista de libros según la categoría
    var listaLibrosModal = document.getElementById('listaLibrosModal');
    if (listaLibrosModal) {
      listaLibrosModal.addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var category = button.getAttribute('data-category');
        var modalTitle = this.querySelector('.modal-title');

        if (category === 'ficcion') {
          modalTitle.textContent = 'Libros de Ficción';
        } else if (category === 'noficcion') {
          modalTitle.textContent = 'Libros de No Ficción';
        } else if (category === 'referencia') {
          modalTitle.textContent = 'Libros de Referencia';
        }
      });
    }

    // Configurar modal de préstamo
    var prestamoModal = document.getElementById('prestamoModal');
    if (prestamoModal) {
      prestamoModal.addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var id = button.getAttribute('data-id');
        var titulo = button.getAttribute('data-titulo');

        var idInput = document.getElementById('prestamoLibroId');
        var tituloInput = document.getElementById('libroTitulo');

        idInput.value = id;
        tituloInput.value = titulo;
      });
    }

    // Configurar modal de devolución
    var devolucionModal = document.getElementById('devolucionModal');
    if (devolucionModal) {
      devolucionModal.addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var id = button.getAttribute('data-id');
        var titulo = button.getAttribute('data-titulo');

        var idInput = document.getElementById('devolucionLibroId');
        var tituloInput = document.getElementById('libroDevolucionTitulo');

        idInput.value = id;
        tituloInput.value = titulo;
      });
    }
  //Boot
    window.addEventListener("load", function () {
      window.botpress.init({
        botId: "ca7cf123-5211-432b-95db-10545f090a33",
        clientId: "ca7cf123-5211-432b-95db-10545f090a33",
        hostUrl: "https://cdn.botpress.cloud/webchat/v2",
        messagingUrl: "https://messaging.botpress.cloud",
        botName: "Asistente Virtual",
        enableConversationDeletion: true,
        stylesheet: "https://cdn.botpress.cloud/webchat/v2.3/themes/default.css",
        showPoweredBy: false
      });
    });

    // Auto-ocultar los mensajes toast después de 5 segundos
    setTimeout(function() {
      var toastElements = document.querySelectorAll('.toast');
      toastElements.forEach(function(toast) {
        var bsToast = new bootstrap.Toast(toast);
        bsToast.hide();
      });
    }, 5000);
  });
</script>
</body>
</html>