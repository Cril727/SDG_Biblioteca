package cris.julian.sdg_biblioteca.model;

import java.util.Date;

public class LibroReferencia extends Libro {
    private String campoAcademico;
    private boolean soloConsulta;

    public LibroReferencia(String titulo, String autor, String isbn, String campoAcademico, boolean soloConsulta) {
        super(1, titulo, autor, 43, 300, 300, isbn, true, new Date(System.currentTimeMillis() - 86400000), new Date(System.currentTimeMillis() + 172800000));
        this.campoAcademico = campoAcademico;
        this.soloConsulta = soloConsulta;
    }

    public String getCampoAcademico() {
        return campoAcademico;
    }

    public boolean isSoloConsulta() {
        return soloConsulta;
    }

    public void setCampoAcademico(String campoAcademico) {
        this.campoAcademico = campoAcademico;
    }

    public void setSoloConsulta(boolean soloConsulta) {
        this.soloConsulta = soloConsulta;
    }
}
