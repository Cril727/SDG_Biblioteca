package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class Prestamo {
    private int id;
    private Libro libro;
    private String nombrePrestador;
    private Date fechaPrestamo;
    private Date fechaLimite;
    private Date fechaDevolucion;
    private String observaciones;

    public Prestamo(int id, Libro libro, String nombrePrestador, Date fechaPrestamo, Date fechaLimite, Date fechaDevolucion) {
        this.id = id;
        this.libro = libro;
        this.nombrePrestador = nombrePrestador;
        this.fechaPrestamo = fechaPrestamo;
        this.fechaLimite = fechaLimite;
        this.fechaDevolucion = fechaDevolucion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
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

    public void setFechaDevolucion(Date fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public boolean isDevuelto() {
        return fechaDevolucion != null;
    }

    public boolean isVencido() {
        if (isDevuelto()) {
            return false;
        }
        Date hoy = new Date();
        return fechaLimite.before(hoy);
    }
}