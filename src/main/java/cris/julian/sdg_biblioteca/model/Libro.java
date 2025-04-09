package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class Libro {

    private static int contadorId = 1;

    private int id;
    private String isbn;
    private String titulo;
    private String autor;
    private boolean prestado;

    public Libro(int i, String titulo, String autor, int i1, int i2, int i3, String isbn, boolean b, Date date, Date date1) {
        this.id = contadorId++; // Genera un ID único
        this.titulo = titulo;
        this.autor = autor;
        this.isbn = isbn;
        this.prestado = false;
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

    @Override
    public String toString() {
        return "Libro ID=" + id + ", Título='" + titulo + "', Autor='" + autor + "', ISBN='" + isbn + "', Prestado=" + prestado;
    }

}
