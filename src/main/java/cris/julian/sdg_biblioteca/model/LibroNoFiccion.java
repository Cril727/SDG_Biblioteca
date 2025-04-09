package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class LibroNoFiccion extends Libro {
    private String areaTematica;
    private String PublicoObjetivo;

    public LibroNoFiccion(String titulo, String autor, String isbn, String areaTematica, String publicoObjetivo) {
        super(1, titulo, autor, 43, 300, 300, isbn, true, new Date(System.currentTimeMillis() - 86400000), new Date(System.currentTimeMillis() + 172800000));
        this.areaTematica = areaTematica;
        PublicoObjetivo = publicoObjetivo;
    }

    public String getAreaTematica() {
        return areaTematica;
    }

    public String getPublicoObjetivo() {
        return PublicoObjetivo;
    }

    public void setAreaTematica(String areaTematica) {
        this.areaTematica = areaTematica;
    }

    public void setPublicoObjetivo(String publicoObjetivo) {
        PublicoObjetivo = publicoObjetivo;
    }
}


