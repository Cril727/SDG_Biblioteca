<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrar Préstamo - Biblioteca Municipal</title>
  <jsp:include page="../cdns.jsp"></jsp:include>
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<%
  // Obtener instancias de los managers
  LibroManager libroManager = LibroManager.getInstance();

  // Obtener el ID del libro
  int libroId = 0;
  Libro libro = null;

  try {
    libroId = Integer.parseInt(request.getParameter("libroId"));
    libro = libroManager.buscarLibroPorId(libroId);
  } catch (Exception e) {
    // Si hay error, redirigir
    session.setAttribute("mensaje", "Error al obtener información del libro");
    session.setAttribute("tipoMensaje", "danger");
    response.sendRedirect("../libros/listar.jsp");
    return;
  }

  // Verificar si el libro existe y está disponible
  if (libro == null) {
    session.setAttribute("mensaje", "El libro solicitado no existe");
    session.setAttribute("tipoMensaje", "danger");
    response.sendRedirect("../libros/listar.jsp");
    return;
  }

  if (libro.isPrestado()) {
    session.setAttribute("mensaje", "El libro ya está prestado");
    session.setAttribute("tipoMensaje", "warning");
    response.sendRedirect("../libros/listar.jsp");
    return;
  }

  if (libro instanceof LibroReferencia && ((LibroReferencia) libro).isSoloConsulta()) {
    session.setAttribute("mensaje", "Este libro es solo para consulta en biblioteca");
    session.setAttribute("tipoMensaje", "warning");
    response.sendRedirect("../libros/listar.jsp");
    return;
  }

  // Calcular fecha de devolución por defecto (15 días)
  Calendar calendar = Calendar.getInstance();
  calendar.add(Calendar.DAY_OF_MONTH, 15);
  Date fechaDevolucion = calendar.getTime();
  String fechaDevolucionStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(fechaDevolucion);
%>

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
          <a class="nav-link" href="../libros/listar.jsp">Libros</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="listar.jsp">Préstamos</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Registrar Préstamo Form -->


<section class="py-5">
  <div class="container">
    <div class="p-5 mb-4 colorjump rounded-3">
      <div class="container-fluid py-5 text-center">
        <h1 class="display-5 fw-bold">Registrar Prestamo</h1>
        <p>Registrar Prestamo</p>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-lg-8">

          <div class="card-body">
            <form id="prestamoForm" action="guardar.jsp" method="post">
              <input type="hidden" name="accion" value="registrar">
              <input type="hidden" name="libroId" value="<%= libro.getId() %>">

              <div class="mb-3">
                <label for="libroTitulo" class="form-label">Libro</label>
                <input type="text" class="form-control" id="libroTitulo" value="<%= libro.getTitulo() %>" readonly>
                <div class="form-text">Autor: <%= libro.getAutor() %> | ISBN: <%= libro.getIsbn() %></div>
              </div>

              <div class="mb-3">
                <label for="usuarioId" class="form-label">Usuario</label>
                <select class="form-select" id="usuarioId" name="usuarioId" required>
                  <option value="" selected disabled>Seleccionar usuario...</option>
                  <option value="María López">María López</option>
                  <option value="Carlos Rodríguez">Carlos Rodríguez</option>
                  <option value="Ana Martínez">Ana Martínez</option>
                  <option value="Juan Pérez">Juan Pérez</option>
                  <option value="Sofía García">Sofía García</option>
                  <option value="Luis Hernández">Luis Hernández</option>
                </select>
              </div>

              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
                  <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" readonly>
                </div>
                <div class="col-md-6">
                  <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
                  <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" value="<%= fechaDevolucionStr %>" required>
                </div>
              </div>

              <div class="mb-3">
                <label for="observaciones" class="form-label">Observaciones</label>
                <textarea class="form-control" id="observaciones" name="observaciones" rows="3" placeholder="Observaciones sobre el estado del libro, condiciones especiales, etc."></textarea>
              </div>

              <div class="d-flex justify-content-end">
                <a href="../libros/listar.jsp" class="btn btn-secondary me-2">Cancelar</a>
                <button type="submit" class="btn btn-success">Registrar Préstamo</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<jsp:include page="../footer.jsp"></jsp:include>

<jsp:include page="../boot.jsp"></jsp:include>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>