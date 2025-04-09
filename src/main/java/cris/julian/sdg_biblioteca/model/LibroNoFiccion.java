package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class LibroNoFiccion extends Libro {
    private String areaTematica;
    private String publicoObjetivo;

    public LibroNoFiccion(String titulo, String autor, String isbn, String areaTematica, String publicoObjetivo) {
        super(titulo, autor, isbn);
        this.areaTematica = areaTematica;
        this.publicoObjetivo = publicoObjetivo;
    }

    public String getAreaTematica() {
        return areaTematica;
    }

    public String getPublicoObjetivo() {
        return publicoObjetivo;
    }

    public void setAreaTematica(String areaTematica) {
        this.areaTematica = areaTematica;
    }

    public void setPublicoObjetivo(String publicoObjetivo) {
        this.publicoObjetivo = publicoObjetivo;
    }
}