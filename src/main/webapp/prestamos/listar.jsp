<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestión de Préstamos - Biblioteca Municipal</title>
  <jsp:include page="../cdns.jsp"></jsp:include>
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<%
  // Obtener instancia del manager
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

  // Obtener listas de préstamos
  List<Prestamo> prestamosActivos = prestamosManager.listarPrestamosActivos();
  List<Prestamo> prestamosDevueltos = prestamosManager.listarPrestamosDevueltos();

  // Filtrar préstamos vencidos
  List<Prestamo> prestamosVencidos = new ArrayList<>();
  for (Prestamo prestamo : prestamosActivos) {
    if (prestamo.isVencido()) {
      prestamosVencidos.add(prestamo);
    }
  }
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

<!-- Loans Section -->
<section class="py-5">
  <div class="container">
    <div class="p-5 mb-4 bg-light rounded-3 ">
      <div class="p-5 mb-4 colorjump rounded-3">
        <div class="container-fluid py-5 text-center">
          <h1 class="display-5 fw-bold">Lista de Libros</h1>
          <p>Lista de Libros</p>
        </div>
      </div>
    <div class="d-flex justify-content-end mb-4">
      <a href="../libros/listar.jsp" class="btn btn-primary">
        <i class="bi bi-plus-lg"></i> Nuevo Préstamo
      </a>
    </div>

    <ul class="nav nav-tabs mb-4" id="prestamosTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="activos-tab" data-bs-toggle="tab" data-bs-target="#activos" type="button" role="tab" aria-controls="activos" aria-selected="true">
          Préstamos Activos <span class="badge bg-primary"><%= prestamosActivos.size() %></span>
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="vencidos-tab" data-bs-toggle="tab" data-bs-target="#vencidos" type="button" role="tab" aria-controls="vencidos" aria-selected="false">
          Vencidos <span class="badge bg-danger"><%= prestamosVencidos.size() %></span>
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="historial-tab" data-bs-toggle="tab" data-bs-target="#historial" type="button" role="tab" aria-controls="historial" aria-selected="false">
          Historial <span class="badge bg-secondary"><%= prestamosDevueltos.size() %></span>
        </button>
      </li>
    </ul>

    <div class="tab-content" id="prestamosTabsContent">
      <!-- Préstamos Activos -->
      <div class="tab-pane fade show active" id="activos" role="tabpanel" aria-labelledby="activos-tab">
        <% if (prestamosActivos.isEmpty()) { %>
        <div class="alert alert-info">No hay préstamos activos actualmente.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped" id="tablaActivos">
            <thead class="table-dark">
            <tr>
              <th>ID</th>
              <th>Libro</th>
              <th>Usuario</th>
              <th>Fecha Préstamo</th>
              <th>Fecha Devolución</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
              for (Prestamo prestamo : prestamosActivos) {
                if (!prestamo.isVencido()) {
            %>
            <tr>
              <td><%= prestamo.getId() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaLimite()) %></td>
              <td><span class="badge bg-success">Al día</span></td>
              <td>
                <a href="devolver.jsp?id=<%= prestamo.getId() %>" class="btn btn-sm btn-primary">
                  <i class="bi bi-arrow-return-left"></i> Devolver
                </a>
              </td>
            </tr>
            <%
                }
              }
              if (prestamosActivos.size() == prestamosVencidos.size() && !prestamosActivos.isEmpty()) {
            %>
            <tr>
              <td colspan="7" class="text-center">No hay préstamos activos al día.</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>

      <!-- Préstamos Vencidos -->
      <div class="tab-pane fade" id="vencidos" role="tabpanel" aria-labelledby="vencidos-tab">
        <% if (prestamosVencidos.isEmpty()) { %>
        <div class="alert alert-success">No hay préstamos vencidos actualmente.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped" id="tablaVencidos">
            <thead class="table-dark">
            <tr>
              <th>ID</th>
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
              for (Prestamo prestamo : prestamosVencidos) {
                long diff = new Date().getTime() - prestamo.getFechaLimite().getTime();
                long diasRetraso = diff / (24 * 60 * 60 * 1000);
            %>
            <tr>
              <td><%= prestamo.getId() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaLimite()) %></td>
              <td><span class="badge bg-danger"><%= diasRetraso %> días</span></td>
              <td>
                <a href="devolver.jsp?id=<%= prestamo.getId() %>" class="btn btn-sm btn-primary">
                  <i class="bi bi-arrow-return-left"></i> Devolver
                </a>
              </td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>

      <!-- Historial de Préstamos -->
      <div class="tab-pane fade" id="historial" role="tabpanel" aria-labelledby="historial-tab">
        <% if (prestamosDevueltos.isEmpty()) { %>
        <div class="alert alert-info">No hay historial de préstamos.</div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-striped" id="tablaHistorial" >
            <thead class="table-dark">
            <tr>
              <th>ID</th>
              <th>Libro</th>
              <th>Usuario</th>
              <th>Fecha Préstamo</th>
              <th>Fecha Devolución</th>
              <th>Estado</th>
              <th>Observaciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Prestamo prestamo : prestamosDevueltos) { %>
            <tr>
              <td><%= prestamo.getId() %></td>
              <td><%= prestamo.getLibro().getTitulo() %></td>
              <td><%= prestamo.getNombrePrestador() %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaPrestamo()) %></td>
              <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(prestamo.getFechaDevolucion()) %></td>
              <td>
                <% if (prestamo.getFechaDevolucion().after(prestamo.getFechaLimite())) { %>
                <span class="badge bg-warning text-dark">Devuelto con retraso</span>
                <% } else { %>
                <span class="badge bg-info">Devuelto a tiempo</span>
                <% } %>
              </td>
              <td><%= prestamo.getObservaciones() != null ? prestamo.getObservaciones() : "-" %></td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<jsp:include page="../footer.jsp"></jsp:include>

<jsp:include page="../boot.jsp"></jsp:include>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript para toasts -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function() {
      $('#tablaActivos').DataTable();
      $('#tablaVencidos').DataTable();
      $('#tablaHistorial').DataTable();
    });
  });
</script>

<%
  String mensaje = (String) session.getAttribute("mensaje");
  String tipoMensaje = (String) session.getAttribute("tipoMensaje");
  if (mensaje != null && tipoMensaje != null) {
%>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    Swal.fire({
      title: "<%= mensaje %>",
      icon: "<%= tipoMensaje %>",
      confirmButtonText: "Aceptar"
    });
  });
</script>
<%
    session.removeAttribute("mensaje");
    session.removeAttribute("tipoMensaje");
  }
%>

</body>
</html>