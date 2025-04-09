package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;
import java.util.Date;

public class prestamoManager {

    private static prestamoManager instance;
    private final ArrayList<Prestamo> prestamos;

    private prestamoManager() {
        this.prestamos = new ArrayList<>();
    }

    public static prestamoManager getInstance() {
        if (instance == null) {
            instance = new prestamoManager();
        }
        return instance;
    }

    public boolean crearPrestamo(Libro libro, String nombrePrestador, Date fechaPrestamo, Date fechaLimite) {
        if (libro.isPrestado()) {
            return false; // El libro ya está prestado
        }
        Prestamo nuevo = new Prestamo(libro.getIsbn(), libro, nombrePrestador, fechaPrestamo, fechaLimite, null);
        prestamos.add(nuevo);
        return true;
    }

    public boolean devolverPrestamo(int libroId, Date fechaDevolucion) {
        for (Prestamo p : prestamos) {
            if (p.getLibro().getId() == libroId && p.isActivo()) {
                p.setFechaDevolucion(fechaDevolucion);
                p.getLibro().setPrestado(false);
                return true;
            }
        }
        return false;
    }

    public ArrayList<Prestamo> listarPrestamos() {
        return prestamos;
    }

    public ArrayList<Prestamo> listarPrestamosActivos() {
        ArrayList<Prestamo> activos = new ArrayList<>();
        for (Prestamo p : prestamos) {
            if (p.isActivo()) {
                activos.add(p);
            }
        }
        return activos;
    }

    public ArrayList<Prestamo> listarPrestamosDevueltos() {
        ArrayList<Prestamo> devueltos = new ArrayList<>();
        for (Prestamo p : prestamos) {
            if (!p.isActivo()) {
                devueltos.add(p);
            }
        }
        return devueltos;
    }
}
