<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, cris.julian.sdg_biblioteca.model.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inventario de Libros - Biblioteca Municipal</title>
  <jsp:include page="../cdns.jsp"></jsp:include>
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
<%
  // Obtener instancia del manager
  LibroManager libroManager = LibroManager.getInstance();
  PrestamoManager prestamosManager = PrestamoManager.getInstance();

  // Obtener parámetros de filtro
  String filtroTitulo = request.getParameter("titulo") != null ? request.getParameter("titulo") : "";
  String filtroAutor = request.getParameter("autor") != null ? request.getParameter("autor") : "";
  String filtroCategoria = request.getParameter("categoria") != null ? request.getParameter("categoria") : "";

  // Obtener todos los libros
  List<Libro> todosLibros = libroManager.listarLibros();

  // Aplicar filtros
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

<!-- Book Inventory -->
<section class="py-5" id="inventario">
  <div class="container">
    <div class="p-5 mb-4 colorjump rounded-3">
      <div class="container-fluid py-5 text-center">
        <h1 class="display-5 fw-bold">Lista de Libros</h1>
        <p>Lista de Libros</p>
      </div>
    </div>


    <a href="agregar.jsp" class="btn btn-primary">

      <i class="bi bi-plus-lg"></i> Agregar Libro
    </a>



      <br>
      <br>

    <div class="table-responsive">
      <table id="tablaLibros" class="table table-striped table-hover">
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
              if (libro instanceof LibroFiccion) categoria = "Ficción";
              else if (libro instanceof LibroNoFiccion) categoria = "No Ficción";
              else if (libro instanceof LibroReferencia) categoria = "Referencia";

              String badgeColor = categoria.equals("Ficción") ? "primary" :
                      categoria.equals("No Ficción") ? "info" : "warning";

              String estadoBadgeColor = libro.isPrestado() ? "warning" : "success";
              String estadoTexto = libro.isPrestado() ? "Prestado" : "Disponible";

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
              <a href="#" class="btn btn-danger" onclick="confirmarEliminacion(<%= libro.getId() %>)">
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

<!-- Footer -->
<jsp:include page="../footer.jsp"></jsp:include>
<jsp:include page="../boot.jsp"></jsp:include>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- DataTable -->
<script>
  $(document).ready(function () {
    $("#tablaLibros").DataTable({
      buttons: [
        { extend: "colvis", text: "Columnas Visibles" },
        "excel", "pdf", "print", "copy"
      ],
      dom: "Bfrtip",
      responsive: true,
      destroy: true,
      language: { url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json' },
      pageLength: 10
    });
  });

  function confirmarEliminacion(libroId) {
    Swal.fire({
      title: '¿Está seguro de eliminar este libro?',
      text: 'Esta acción no se puede deshacer.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = 'eliminar.jsp?id=' + libroId;
      }
    });
  }
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
