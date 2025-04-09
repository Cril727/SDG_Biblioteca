package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;
import java.util.List;

public class Inventario {
    static List<Libro> libroList = new ArrayList<>();

    static {
        // Crear libros de ficción
        LibroFiccion libro1 = new LibroFiccion("1984", "George Orwell", "978-0451524935", "novela", 2);
        libro1.setEditorial("Ficción");
        libro1.setAnioPublicacion(1949);
        libro1.setDescripcion("Una distopía que retrata un futuro totalitario y vigilado.");

        LibroFiccion libro2 = new LibroFiccion("El Principito", "Antoine de Saint-Exupéry", "978-0156012195", "novela", 1);
        libro2.setEditorial("Ficción");
        libro2.setAnioPublicacion(1943);
        libro2.setDescripcion("Una fábula sobre un pequeño príncipe que viaja por diferentes planetas.");


        // Crear libros de no ficción
        LibroNoFiccion libro3 = new LibroNoFiccion("Una breve historia del tiempo", "Stephen Hawking", "978-0553380163", "ciencia", "general");
        libro3.setEditorial("No ficción");
        libro3.setAnioPublicacion(1988);
        libro3.setDescripcion("Un libro de divulgación científica sobre cosmología.");


        LibroNoFiccion libro4 = new LibroNoFiccion("Sapiens", "Yuval Noah Harari", "978-0062316097", "historia", "general");
        libro4.setEditorial("No ficción");
        libro4.setAnioPublicacion(2014);
        libro4.setDescripcion("Un recorrido por la historia de la humanidad.");


        // Añadir todos los libros a la lista
        libroList.add(libro1);
        libroList.add(libro2);
        libroList.add(libro3);
        libroList.add(libro4);

    }

    public static List<Libro> getLibroList() {
        return libroList;
    }

    public static void anadirLibro(Libro libro) {
        libroList.add(libro);
    }
}