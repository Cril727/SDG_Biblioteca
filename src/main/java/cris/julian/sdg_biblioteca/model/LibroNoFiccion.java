package cris.julian.sdg_biblioteca.model;

public class LibroNoFiccion extends Libro {
    private String areaTematica;
    private String PublicoObjetivo;

    public LibroNoFiccion(String titulo, String autor, String isbn, String areaTematica, String publicoObjetivo) {
        super(titulo, autor, isbn);
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


