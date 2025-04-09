package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class LibroFiccion extends Libro {
    private String genero;
    private int premiosLiterarios;

    public LibroFiccion(String titulo, String autor, String isbn, String genero, int premiosLiterarios) {
        super(titulo, autor, isbn);
        this.genero = genero;
        this.premiosLiterarios = premiosLiterarios;
    }

    public String getGenero() {
        return genero;
    }

    public int getPremios() {
        return premiosLiterarios;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public void setPremios(int premiosLiterarios) {
        this.premiosLiterarios = premiosLiterarios;
    }
}