package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;
import java.util.List;

public class LibroManager {
    private static LibroManager instance;
    private final List<Libro> libros;

    private LibroManager() {
        this.libros = new ArrayList<>();
        // Inicializar con datos de Inventario si existe
        if (Inventario.getLibroList() != null && !Inventario.getLibroList().isEmpty()) {
            this.libros.addAll(Inventario.getLibroList());
        }
    }

    public static LibroManager getInstance() {
        if (instance == null) {
            instance = new LibroManager();
        }
        return instance;
    }

    public void agregarLibro(Libro libro) {
        libros.add(libro);

        Inventario.anadirLibro(libro);
    }

    public List<Libro> listarLibros() {
        return new ArrayList<>(libros);
    }

    public Libro buscarLibroPorId(int id) {
        for (Libro libro : libros) {
            if (libro.getId() == id) {
                return libro;
            }
        }
        return null;
    }

    public boolean eliminarLibroPorId(int id) {
        Libro libro = buscarLibroPorId(id);
        if (libro != null && !libro.isPrestado()) {
            libros.remove(libro);
            return true;
        }
        return false;
    }
}