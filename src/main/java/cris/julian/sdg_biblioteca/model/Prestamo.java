package cris.julian.sdg_biblioteca.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Prestamo {

    private String isbn;
    private Libro libro;
    private String nombrePrestador;
    private Date fechaPrestamo;
    private Date fechaLimite;
    private Date fechaDevolucion;

    public Prestamo(String isbn, Libro libro, String nombrePrestador, Date fechaPrestamo, Date fechaLimite, Date fechaDevolucion) {
        this.isbn = isbn;
        this.libro = libro;
        this.nombrePrestador = nombrePrestador;
        this.fechaPrestamo = fechaPrestamo;
        this.fechaLimite = fechaLimite;
        this.fechaDevolucion = fechaDevolucion;

        libro.setPrestado(true);
    }


    //Getters and Setters


    public String getIsbn() {
        return isbn;
    }

    public Libro getLibro() {
        return libro;
    }

    public String getNombrePrestador() {
        return nombrePrestador;
    }

    public Date getFechaPrestamo() {
        return fechaPrestamo;
    }

    public Date getFechaLimite() {
        return fechaLimite;
    }

    public Date getFechaDevolucion() {
        return fechaDevolucion;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public void setNombrePrestador(String nombrePrestador) {
        this.nombrePrestador = nombrePrestador;
    }

    public void setFechaPrestamo(Date fechaPrestamo) {
        this.fechaPrestamo = fechaPrestamo;
    }

    public void setFechaLimite(Date fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

    public void setFechaDevolucion(Date fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    //Es Activo
    public boolean isActivo() {
        return fechaDevolucion == null;
    }

    public boolean isVencido() {
        if (!isActivo()) {
            return false;
        }
        Date hoy = new Date();
        return hoy.after(fechaLimite);
    }


    @Override
    public String toString() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        return "Préstamo ID = " + isbn +
                "\nLibro = " + libro.getTitulo() + " (" + libro.getIsbn() + ")" +
                "\nPrestador = " + nombrePrestador +
                "\nFecha de Préstamo = " + dateFormat.format(fechaPrestamo) +
                "\nFecha Límite = " + dateFormat.format(fechaLimite) +
                "\nFecha de Devolución = " + (fechaDevolucion != null ? dateFormat.format(fechaDevolucion) : "No devuelto") +
                "\nEstado = " + (isActivo() ? (isVencido() ? "Vencido" : "Activo") : "Devuelto");
    }

}
