package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;

public class LibroManager {

    private static LibroManager instance;
    private final ArrayList<Libro> libros;

    // Constructor privado para el patrón Singleton
    private LibroManager() {
        this.libros = new ArrayList<>();
    }

    // Método para obtener la instancia única del gestor
    public static LibroManager getInstance() {
        if (instance == null) {
            instance = new LibroManager();
        }
        return instance;
    }

    // Agregar libro
    public void agregarLibro(Libro libro) {
        libros.add(libro);
    }

    // Listar todos los libros
    public ArrayList<Libro> listarLibros() {
        return libros;
    }

    // Buscar libro por ID
    public Libro buscarLibroPorId(int id) {
        for (Libro libro : libros) {
            if (libro.getId() == id) {
                return libro;
            }
        }
        return null;
    }

    // Eliminar libro por ID
    public boolean eliminarLibroPorId(int id) {
        return libros.removeIf(libro -> libro.getId() == id);
    }

    // Actualizar libro por ID
    public void actualizarLibro(int id, Libro libroActualizado) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getId() == id) {
                libros.set(i, libroActualizado);
                break;
            }
        }
    }
}
