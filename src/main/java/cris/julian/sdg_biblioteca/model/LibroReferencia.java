package cris.julian.sdg_biblioteca.model;

public class LibroReferencia extends Libro {
    private String campoAcademico;
    private boolean soloConsulta;

    public LibroReferencia(String titulo, String autor, String isbn, String campoAcademico, boolean soloConsulta) {
        super(titulo, autor, isbn);
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
