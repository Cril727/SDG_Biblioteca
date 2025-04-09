package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PrestamoManager {

    private static PrestamoManager instance;
    private final ArrayList<Prestamo> prestamos;
    private int nextId = 1;

    private PrestamoManager() {
        this.prestamos = new ArrayList<>();
    }

    public static PrestamoManager getInstance() {
        if (instance == null) {
            instance = new PrestamoManager();
        }
        return instance;
    }

    public boolean crearPrestamo(Libro libro, String nombrePrestador, Date fechaPrestamo, Date fechaLimite) {
        if (libro.isPrestado()) {
            return false; // El libro ya está prestado
        }

        // Marcar el libro como prestado
        libro.setPrestado(true);

        // Crear el nuevo préstamo con ID único
        Prestamo nuevo = new Prestamo(nextId++, libro, nombrePrestador, fechaPrestamo, fechaLimite, null);
        prestamos.add(nuevo);
        return true;
    }

    public boolean devolverPrestamo(int prestamoId, Date fechaDevolucion) {
        for (Prestamo p : prestamos) {
            if (p.getId() == prestamoId && !p.isDevuelto()) {
                p.setFechaDevolucion(fechaDevolucion);
                p.getLibro().setPrestado(false);
                return true;
            }
        }
        return false;
    }

    public Prestamo buscarPrestamoPorId(int prestamoId) {
        for (Prestamo p : prestamos) {
            if (p.getId() == prestamoId) {
                return p;
            }
        }
        return null;
    }

    public Prestamo buscarPrestamoActivoPorLibroId(int libroId) {
        for (Prestamo p : prestamos) {
            if (p.getLibro().getId() == libroId && !p.isDevuelto()) {
                return p;
            }
        }
        return null;
    }

    public List<Prestamo> listarPrestamos() {
        return new ArrayList<>(prestamos);
    }

    public List<Prestamo> listarPrestamosActivos() {
        ArrayList<Prestamo> activos = new ArrayList<>();
        for (Prestamo p : prestamos) {
            if (!p.isDevuelto()) {
                activos.add(p);
            }
        }
        return activos;
    }

    public List<Prestamo> listarPrestamosDevueltos() {
        ArrayList<Prestamo> devueltos = new ArrayList<>();
        for (Prestamo p : prestamos) {
            if (p.isDevuelto()) {
                devueltos.add(p);
            }
        }
        return devueltos;
    }
}