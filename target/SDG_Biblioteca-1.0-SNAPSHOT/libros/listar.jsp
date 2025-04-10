<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inventario de Libros - Biblioteca Municipal</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

  <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<%

  LibroManager libroManager = LibroManager.getInstance();
  PrestamoManager prestamosManager = PrestamoManager.getInstance();


  String filtroTitulo = request.getParameter("titulo") != null ? request.getParameter("titulo") : "";
  String filtroAutor = request.getParameter("autor") != null ? request.getParameter("autor") : "";
  String filtroCategoria = request.getParameter("categoria") != null ? request.getParameter("categoria") : "";


  List<Libro> todosLibros = libroManager.listarLibros();


  List<Libro> libros = new ArrayList<>();

  for (Libro libro : todosLibros) {
    boolean cumpleFiltroTitulo = filtroTitulo.isEmpty() || libro.getTitulo().toLowerCase().contains(filtroTitulo.toLowerCase());
    boolean cumpleFiltroAutor = filtroAutor.isEmpty() || libro.getAutor().toLowerCase().contains(filtroAutor.toLowerCase());
    boolean cumpleFiltroCategoria = filtroCategoria.isEmpty() ||
            (filtroCategoria.equals("ficcion") && libro instanceof LibroFiccion) ||
            (filtroCategoria.equals("noficcion") && libro instanceof LibroNoFiccion) ||
            (filtroCategoria.equals("referencia") && libro instanceof LibroReferencia);

    if (cumpleFiltroTitulo && cumpleFiltroAutor && cumpleFiltroCategoria) {
      libros.add(libro);
    }
  }
%>


<nav class="navbar navbar-expand-lg navbar-dark bg-library">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="../index.jsp">
      <i class="bi bi-book me-2"></i>
      <span>BiblioTech</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="../index.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="listar.jsp">Libros</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../prestamos/listar.jsp">Préstamos</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


<% if (session.getAttribute("mensaje") != null) { %>
<div class="toast-container">
  <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header bg-<%= session.getAttribute("tipoMensaje") %> text-white">
      <strong class="me-auto">Notificación</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      <%= session.getAttribute("mensaje") %>
    </div>
  </div>
</div>
<%
  session.removeAttribute("mensaje");
  session.removeAttribute("tipoMensaje");
%>
<% } %>


<section class="py-5" id="inventario">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Inventario de Libros</h2>
      <a href="agregar.jsp" class="btn btn-primary">
        <i class="bi bi-plus-lg"></i> Agregar Libro
      </a>
    </div>

    <div class="card mb-4">
      <div class="card-body">
        <form action="listar.jsp" method="get" class="row g-3">
          <div class="col-md-4">
            <label for="filtroTitulo" class="form-label">Título</label>
            <input type="text" class="form-control" id="filtroTitulo" name="titulo" placeholder="Buscar por título" value="<%= filtroTitulo %>">
          </div>
          <div class="col-md-3">
            <label for="filtroAutor" class="form-label">Autor</label>
            <input type="text" class="form-control" id="filtroAutor" name="autor" placeholder="Buscar por autor" value="<%= filtroAutor %>">
          </div>
          <div class="col-md-3">
            <label for="filtroCategoria" class="form-label">Categoría</label>
            <select class="form-select" id="filtroCategoria" name="categoria">
              <option value="" <%= filtroCategoria.isEmpty() ? "selected" : "" %>>Todas</option>
              <option value="ficcion" <%= filtroCategoria.equals("ficcion") ? "selected" : "" %>>Ficción</option>
              <option value="noficcion" <%= filtroCategoria.equals("noficcion") ? "selected" : "" %>>No Ficción</option>
              <option value="referencia" <%= filtroCategoria.equals("referencia") ? "selected" : "" %>>Referencia</option>
            </select>
          </div>
          <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100">Filtrar</button>
          </div>
        </form>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Título</th>
          <th>Autor</th>
          <th>ISBN</th>
          <th>Categoría</th>
          <th>Estado</th>
          <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (libros != null && !libros.isEmpty()) {
            for (Libro libro : libros) {
              String categoria = "";
              if (libro instanceof LibroFiccion) {
                categoria = "Ficción";
              } else if (libro instanceof LibroNoFiccion) {
                categoria = "No Ficción";
              } else if (libro instanceof LibroReferencia) {
                categoria = "Referencia";
              }

              String badgeColor = "";
              if (categoria.equals("Ficción")) {
                badgeColor = "primary";
              } else if (categoria.equals("No Ficción")) {
                badgeColor = "info";
              } else if (categoria.equals("Referencia")) {
                badgeColor = "warning";
              }

              String estadoBadgeColor = libro.isPrestado() ? "warning" : "success";
              String estadoTexto = libro.isPrestado() ? "Prestado" : "Disponible";

              // Si es un libro de referencia y solo consulta, mostrar estado especial
              if (libro instanceof LibroReferencia && ((LibroReferencia) libro).isSoloConsulta()) {
                estadoBadgeColor = "danger";
                estadoTexto = "Solo Consulta";
              }
        %>
        <tr>
          <td><%= libro.getId() %></td>
          <td><%= libro.getTitulo() %></td>
          <td><%= libro.getAutor() %></td>
          <td><%= libro.getIsbn() %></td>
          <td><span class="badge bg-<%= badgeColor %>"><%= categoria %></span></td>
          <td><span class="badge bg-<%= estadoBadgeColor %>"><%= estadoTexto %></span></td>
          <td class="table-actions">
            <div class="btn-group btn-group-sm">
              <a href="editar.jsp?id=<%= libro.getId() %>" class="btn btn-info">
                <i class="bi bi-pencil"></i>
              </a>
              <a href="eliminar.jsp?id=<%= libro.getId() %>" class="btn btn-danger" onclick="return confirm('¿Está seguro de eliminar este libro?')">
                <i class="bi bi-trash"></i>
              </a>
              <% if (!libro.isPrestado() && !(libro instanceof LibroReferencia && ((LibroReferencia) libro).isSoloConsulta())) { %>
              <a href="../prestamos/registrar.jsp?libroId=<%= libro.getId() %>" class="btn btn-success">
                <i class="bi bi-arrow-right"></i>
              </a>
              <% } else if (libro.isPrestado()) { %>
              <a href="../prestamos/devolver.jsp?libroId=<%= libro.getId() %>" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i>
              </a>
              <% } else { %>
              <button class="btn btn-secondary" disabled>
                <i class="bi bi-arrow-right"></i>
              </button>
              <% } %>
            </div>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="7" class="text-center">No hay libros registrados</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</section>


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
          <li><a href="../index.jsp" class="text-white-50">Inicio</a></li>
          <li><a href="listar.jsp" class="text-white-50">Libros</a></li>
          <li><a href="../prestamos/listar.jsp" class="text-white-50">Préstamos</a></li>
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
<jsp:include page="../boot.jsp"></jsp:include>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>


<script>
  document.addEventListener('DOMContentLoaded', function() {

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