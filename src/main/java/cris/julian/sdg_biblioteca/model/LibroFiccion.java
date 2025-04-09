package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class LibroFiccion extends Libro {
    private String genero;
    private int premiosLiterarios;

    public LibroFiccion(String titulo, String autor, String isbn, String genero, int premiosLiterarios) {
        super(1, titulo, autor, 43, 300, 300, isbn, true, new Date(System.currentTimeMillis() - 86400000), new Date(System.currentTimeMillis() + 172800000)); // ✔️ No necesitas pasar el ID
        this.genero = genero;
        this.premiosLiterarios = premiosLiterarios;
    }

    public String getGenero() {
        return genero;
    }

    public int getPremiosLiterarios() {
        return premiosLiterarios;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public void setPremiosLiterarios(int premiosLiterarios) {
        this.premiosLiterarios = premiosLiterarios;
    }
}
