<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Agregar Libro - Biblioteca Municipal</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<!-- Navbar -->
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

<!-- Agregar Libro Form -->
<section class="py-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="card shadow">
          <div class="card-header bg-primary text-white">
            <h3 class="card-title mb-0">Agregar Nuevo Libro</h3>
          </div>
          <div class="card-body">
            <form id="agregarLibroForm" action="guardar.jsp" method="post">
              <input type="hidden" name="accion" value="agregar">
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
                    <input type="number" class="form-control" id="premios" name="premios" value="0" min="0">
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
                    <label for="tipoPrestamo" class="form-label">Tipo de Préstamo</label>
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
              <div class="d-flex justify-content-end">
                <a href="listar.jsp" class="btn btn-secondary me-2">Cancelar</a>
                <button type="submit" class="btn btn-primary">Guardar Libro</button>
              </div>
            </form>
          </div>
        </div>
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

<!-- JavaScript para campos dinámicos -->
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
</script>
</body>
</html>