<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Footer -->
<footer class="bg-dark text-white py-4">
  <div class="container col-md-10 mx-auto">
    <div class="row">
      <div class="col-md-5 mb-4 mb-md-0">
        <h5 class="mb-3">BiblioTech</h5>
        <p class="mb-0">Sistema de gestión para bibliotecas municipales, desarrollado para mejorar la experiencia de usuarios y administradores.</p>
      </div>
      <div class="col-md-3 mb-4 mb-md-0">
        <h5 class="mb-3">Enlaces</h5>
        <ul class="list-unstyled">
          <li><a href="../index.jsp" class="text-white-50">Inicio</a></li>
          <li><a href="listar.jsp" class="text-white-50">Libros</a></li>
          <li><a href="../prestamos/listar.jsp" class="text-white-50">Préstamos</a></li>
        </ul>
      </div>
      <div class="col-md-3">
        <h5 class="mb-3">Contacto</h5>
        <ul class="list-unstyled text-white-50">
          <li><i class="bi bi-geo-alt me-2"></i> Biblioteca Municipal de Duitama</li>
          <li><i class="bi bi-building me-2"></i> Calle Principal #123</li>
          <li><i class="bi bi-envelope me-2"></i> contacto@biblioteca.gov.co</li>
          <li><i class="bi bi-telephone me-2"></i> +57 3124314119</li>
        </ul>
      </div>
    </div>
    <hr class="my-4 bg-light">
    <div class="text-center text-white-50">
      <p class="mb-0">© <%= new java.util.Date().getYear() + 1900 %> Sistema de Gestión de Biblioteca Municipal. Todos los derechos reservados.</p>
    </div>
  </div>
</footer>
