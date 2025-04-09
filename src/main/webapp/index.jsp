<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
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
                            <small class="text-muted">243 libros</small>
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
                            <small class="text-muted">187 libros</small>
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
                            <small class="text-muted">95 libros</small>
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
                <tr>
                    <td>001</td>
                    <td>Cien años de soledad</td>
                    <td>Gabriel García Márquez</td>
                    <td><span class="badge bg-primary">Ficción</span></td>
                    <td><span class="badge bg-success">Disponible</span></td>
                    <td>
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editarLibroModal">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-danger">
                                <i class="bi bi-trash"></i>
                            </button>
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#prestamoModal">
                                <i class="bi bi-arrow-right"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>002</td>
                    <td>El principito</td>
                    <td>Antoine de Saint-Exupéry</td>
                    <td><span class="badge bg-primary">Ficción</span></td>
                    <td><span class="badge bg-warning text-dark">Prestado</span></td>
                    <td>
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editarLibroModal">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-danger">
                                <i class="bi bi-trash"></i>
                            </button>
                            <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#devolucionModal">
                                <i class="bi bi-arrow-left"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>003</td>
                    <td>Historia del tiempo</td>
                    <td>Stephen Hawking</td>
                    <td><span class="badge bg-info">No Ficción</span></td>
                    <td><span class="badge bg-success">Disponible</span></td>
                    <td>
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editarLibroModal">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-danger">
                                <i class="bi bi-trash"></i>
                            </button>
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#prestamoModal">
                                <i class="bi bi-arrow-right"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>004</td>
                    <td>Diccionario de la lengua española</td>
                    <td>Real Academia Española</td>
                    <td><span class="badge bg-warning">Referencia</span></td>
                    <td><span class="badge bg-danger">Solo Consulta</span></td>
                    <td>
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editarLibroModal">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-danger">
                                <i class="bi bi-trash"></i>
                            </button>
                            <button class="btn btn-secondary" disabled>
                                <i class="bi bi-arrow-right"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <nav aria-label="Paginación de inventario">
            <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Anterior</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Siguiente</a>
                </li>
            </ul>
        </nav>
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
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
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
                        <tr>
                            <td>P001</td>
                            <td>El principito</td>
                            <td>Carlos Rodríguez</td>
                            <td>15/03/2025</td>
                            <td>29/03/2025</td>
                            <td><span class="badge bg-success">Al día</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#devolucionModal">
                                    <i class="bi bi-arrow-return-left"></i> Devolver
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>P002</td>
                            <td>Don Quijote de la Mancha</td>
                            <td>Ana Martínez</td>
                            <td>10/03/2025</td>
                            <td>24/03/2025</td>
                            <td><span class="badge bg-warning text-dark">Próximo a vencer</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#devolucionModal">
                                    <i class="bi bi-arrow-return-left"></i> Devolver
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="tab-pane fade" id="historial" role="tabpanel" aria-labelledby="historial-tab">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Libro</th>
                            <th>Usuario</th>
                            <th>Fecha Préstamo</th>
                            <th>Fecha Devolución</th>
                            <th>Estado</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>P003</td>
                            <td>Crónica de una muerte anunciada</td>
                            <td>María López</td>
                            <td>01/03/2025</td>
                            <td>10/03/2025</td>
                            <td><span class="badge bg-info">Devuelto</span></td>
                        </tr>
                        <tr>
                            <td>P004</td>
                            <td>La metamorfosis</td>
                            <td>Juan Pérez</td>
                            <td>25/02/2025</td>
                            <td>05/03/2025</td>
                            <td><span class="badge bg-info">Devuelto</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="tab-pane fade" id="vencidos" role="tabpanel" aria-labelledby="vencidos-tab">
                <div class="alert alert-success">
                    No hay préstamos vencidos actualmente.
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
                <i class="bi bi-book fs-1 mb-2"></i>
                <h3 class="h2">5,000+</h3>
                <p>Libros en Catálogo</p>
            </div>
            <div class="col-md-3 mb-4 mb-md-0">
                <i class="bi bi-people fs-1 mb-2"></i>
                <h3 class="h2">1,200+</h3>
                <p>Usuarios Registrados</p>
            </div>
            <div class="col-md-3 mb-4 mb-md-0">
                <i class="bi bi-arrow-left-right fs-1 mb-2"></i>
                <h3 class="h2">500+</h3>
                <p>Préstamos Mensuales</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-calendar-check fs-1 mb-2"></i>
                <h3 class="h2">20+</h3>
                <p>Años de Servicio</p>
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
                    <li><a href="#usuarios" class="text-white-50">Usuarios</a></li>
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
            <p class="mb-0">© 2025 Sistema de Gestión de Biblioteca Municipal. Todos los derechos reservados.</p>
        </div>
    </div>
</footer>



<!-- Editar Libro Modal -->
<div class="modal fade" id="editarLibroModal" tabindex="-1" aria-labelledby="editarLibroModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarLibroModalLabel">Editar Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario similar al de agregar pero con datos precargados -->
                <form id="editarLibroForm">
                    <!-- Campos similares al formulario de agregar -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary">Guardar Cambios</button>
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
                <form id="prestamoForm">
                    <div class="mb-3">
                        <label for="libroId" class="form-label">Libro</label>
                        <input type="text" class="form-control" id="libroId" value="Cien años de soledad" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="usuarioId" class="form-label">Usuario</label>
                        <select class="form-select" id="usuarioId" required>
                            <option value="" selected disabled>Seleccionar usuario...</option>
                            <option value="1">María López</option>
                            <option value="2">Carlos Rodríguez</option>
                            <option value="3">Ana Martínez</option>
                            <option value="4">Juan Pérez</option>
                        </select>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
                            <input type="date" class="form-control" id="fechaPrestamo" value="2025-04-07" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
                            <input type="date" class="form-control" id="fechaDevolucion" value="2025-04-21" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="observaciones" class="form-label">Observaciones</label>
                        <textarea class="form-control" id="observaciones" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success">Registrar Préstamo</button>
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
                <form id="devolucionForm">
                    <div class="mb-3">
                        <label for="prestamoId" class="form-label">ID Préstamo</label>
                        <input type="text" class="form-control" id="prestamoId" value="P001" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="libroDevolucion" class="form-label">Libro</label>
                        <input type="text" class="form-control" id="libroDevolucion" value="El principito" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="usuarioDevolucion" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="usuarioDevolucion" value="Carlos Rodríguez" readonly>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fechaPrestamoDevolucion" class="form-label">Fecha de Préstamo</label>
                            <input type="date" class="form-control" id="fechaPrestamoDevolucion" value="2025-03-15" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="fechaDevolucionReal" class="form-label">Fecha de Devolución</label>
                            <input type="date" class="form-control" id="fechaDevolucionReal" value="2025-04-07" readonly>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="estadoLibro" class="form-label">Estado del Libro</label>
                        <select class="form-select" id="estadoLibro" required>
                            <option value="bueno" selected>Bueno</option>
                            <option value="regular">Regular</option>
                            <option value="malo">Malo</option>
                            <option value="dañado">Dañado</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="observacionesDevolucion" class="form-label">Observaciones</label>
                        <textarea class="form-control" id="observacionesDevolucion" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary">Registrar Devolución</button>
            </div>
        </div>
    </div>
</div>

<!-- Lista de Libros Modal -->
<div class="modal fade" id="listaLibrosModal" tabindex="-1" aria-labelledby="listaLibrosModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="listaLibrosModalLabel">Libros de Ficción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Buscar por título, autor...">
                    <button class="btn btn-outline-secondary" type="button">Buscar</button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Año</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Contenido dinámico según la categoría seleccionada -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

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

    // Inicializar tooltips y popovers de Bootstrap
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

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
    });

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
</script>
</body>
</html>