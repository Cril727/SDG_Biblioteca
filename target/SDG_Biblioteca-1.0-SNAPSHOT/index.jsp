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
</head>
<body>
<%
  // Obtener instancias de los managers
  LibroManager libroManager = LibroManager.getInstance();
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

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
    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
      <i class="bi bi-book me-2"></i>
      <span>BiblioTech</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="index.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="libros/listar.jsp">Libros</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="prestamos/listar.jsp">Préstamos</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Toast para mensajes -->
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
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="card-body text-center">
            <i class="bi bi-plus-circle text-primary fs-1 mb-3"></i>
            <h5 class="card-title">Agregar Libro</h5>
            <p class="card-text">Registra un nuevo libro en el sistema</p>
            <a href="libros/agregar.jsp" class="btn btn-outline-primary">
              Agregar
            </a>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="card-body text-center">
            <i class="bi bi-search text-info fs-1 mb-3"></i>
            <h5 class="card-title">Buscar Libros</h5>
            <p class="card-text">Consulta el catálogo de libros</p>
            <a href="libros/listar.jsp" class="btn btn-outline-info">Buscar</a>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 card-hover">
          <div class="card-body text-center">
            <i class="bi bi-arrow-left-right text-success fs-1 mb-3"></i>
            <h5 class="card-title">Préstamos</h5>
            <p class="card-text">Gestiona préstamos y devoluciones</p>
            <a href="prestamos/listar.jsp" class="btn btn-outline-success">Gestionar</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Book Categories -->
<section class="py-5 bg-light">
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
              <a href="libros/listar.jsp?categoria=ficcion" class="btn btn-sm btn-primary">Ver todos</a>
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
              <a href="libros/listar.jsp?categoria=noficcion" class="btn btn-sm btn-primary">Ver todos</a>
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
              <a href="libros/listar.jsp?categoria=referencia" class="btn btn-sm btn-primary">Ver todos</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Stats Section -->
<section class="py-5 bg-primary text-white">
  <div class="container">
    <div class="row text-center">
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-book stats-icon"></i>
        <h3 class="h2"><%= libros.size() %></h3>
        <p>Libros en Catálogo</p>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-people stats-icon"></i>
        <h3 class="h2">
          <%= new HashSet<String>() {{
            for (Prestamo p : prestamosActivos) add(p.getNombrePrestador());
            for (Prestamo p : prestamosDevueltos) add(p.getNombrePrestador());
          }}.size() %>
        </h3>
        <p>Usuarios Activos</p>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <i class="bi bi-arrow-left-right stats-icon"></i>
        <h3 class="h2"><%= prestamosActivos.size() %></h3>
        <p>Préstamos Activos</p>
      </div>
      <div class="col-md-3">
        <i class="bi bi-calendar-check stats-icon"></i>
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
          <li><a href="index.jsp" class="text-white-50">Inicio</a></li>
          <li><a href="libros/listar.jsp" class="text-white-50">Libros</a></li>
          <li><a href="prestamos/listar.jsp" class="text-white-50">Préstamos</a></li>
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

<jsp:include page="boot.jsp"></jsp:include>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript para toasts -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
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