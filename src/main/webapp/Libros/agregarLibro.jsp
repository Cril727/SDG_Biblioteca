<%--
  Created by IntelliJ IDEA.
  User: cristian
  Date: 9/4/25
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
                <form id="agregarLibroForm">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="titulo" class="form-label">Título</label>
                            <input type="text" class="form-control" id="titulo" required>
                        </div>
                        <div class="col-md-6">
                            <label for="autor" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="autor" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="isbn" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="isbn" required>
                        </div>
                        <div class="col-md-4">
                            <label for="anioPublicacion" class="form-label">Año de Publicación</label>
                            <input  class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="anioPublicacion" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editorial" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="editorial" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="tipoLibro" class="form-label">Tipo de Libro</label>
                        <select class="form-select" id="tipoLibro" required onchange="mostrarCamposDinamicos()">
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
                                <select class="form-select" id="genero">
                                    <option value="novela">Novela</option>
                                    <option value="cuento">Cuento</option>
                                    <option value="poesia">Poesía</option>
                                    <option value="teatro">Teatro</option>
                                    <option value="otro">Otro</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="premios" class="form-label">Premios Literarios</label>
                                <input type="text" class="form-control" id="premios" placeholder="Opcional">
                            </div>
                        </div>
                    </div>

                    <!-- Campos dinámicos para No Ficción -->
                    <div id="camposNoFiccion" class="campos-dinamicos" style="display: none;">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="areaTematica" class="form-label">Área Temática</label>
                                <select class="form-select" id="areaTematica">
                                    <option value="historia">Historia</option>
                                    <option value="ciencia">Ciencia</option>
                                    <option value="biografia">Biografía</option>
                                    <option value="autoayuda">Autoayuda</option>
                                    <option value="otro">Otro</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
                                <select class="form-select" id="publicoObjetivo">
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
                                <select class="form-select" id="campoAcademico">
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
                        <textarea class="form-control" id="descripcion" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="portada" class="form-label">Imagen de Portada</label>
                        <input class="form-control" type="file" id="portada">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary">Guardar Libro</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
