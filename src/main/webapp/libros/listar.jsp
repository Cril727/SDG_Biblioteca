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

<!-- Book Inventory -->
<section class="py-5" id="inventario">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Inventario de Libros</h2>
      <a href="agregar.jsp" class="btn btn-primary">
        <i class="bi bi-plus-lg"></i> Agregar Libro
      </a>
    </div>

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

<!-- Footer -->
<jsp:include page="../footer.jsp"></jsp:include>

<jsp:include page="../boot.jsp"></jsp:include>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript para toasts -->
<script>
  $(document).ready(function () {
    $("#tablaLibros").DataTable({
      buttons: [
        {
          extend: "colvis",
          text: "Columnas Visibles"
        },
        "excel",
        "pdf",
        "print",
        "copy"
      ],
      dom: "Bfrtip",
      responsive: true,
      destroy: true,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json'
      },
      responsive: true,
      pageLength: 10,
    });

    // Auto-ocultar los mensajes toast después de 5 segundos
    setTimeout(function () {
      $('.toast').each(function () {
        var bsToast = bootstrap.Toast.getOrCreateInstance(this);
        bsToast.hide();
      });
    }, 5000);
  });

</script>

</body>
</html>