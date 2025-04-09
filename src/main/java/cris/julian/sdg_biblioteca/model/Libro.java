package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class Libro {

    private static int contadorId = 1;

    private int id;
    private String isbn;
    private String titulo;
    private String autor;
    private boolean prestado;
    private String editorial;
    private int anioPublicacion;
    private String descripcion;

    public Libro(String titulo, String autor, String isbn) {
        this.id = contadorId++; // Genera un ID único
        this.titulo = titulo;
        this.autor = autor;
        this.isbn = isbn;
        this.prestado = false;
    }

    // Constructor para compatibilidad con código existente
    public Libro(int id, String titulo, String autor, int anioPublicacion, int paginas, int precio,
                 String isbn, boolean prestado, Date fechaPrestamo, Date fechaDevolucion) {
        this.id = contadorId++; // Genera un ID único
        this.titulo = titulo;
        this.autor = autor;
        this.isbn = isbn;
        this.anioPublicacion = anioPublicacion;
        this.prestado = prestado;
    }

    // Getters y Setters

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getAutor() {
        return autor;
    }

    public String getIsbn() {
        return isbn;
    }

    public boolean isPrestado() {
        return prestado;
    }

    public String getEditorial() {
        return editorial;
    }

    public int getAnioPublicacion() {
        return anioPublicacion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setPrestado(boolean prestado) {
        this.prestado = prestado;
    }

    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

    public void setAnioPublicacion(int anioPublicacion) {
        this.anioPublicacion = anioPublicacion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return "Libro ID=" + id + ", Título='" + titulo + "', Autor='" + autor + "', ISBN='" + isbn + "', Prestado=" + prestado;
    }
}