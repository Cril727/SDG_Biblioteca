package cris.julian.sdg_biblioteca.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Inventario {
    static List<Libro> libroList = new ArrayList<>();

    static {
        libroList.add(new Libro(1, "100 años de soledad", "Gabriel", 43, 300, 300,"la que sea", true, new Date(System.currentTimeMillis() - 86400000), new Date(System.currentTimeMillis() + 172800000)));
        libroList.add(new Libro(2, "Ama y no sufras", "Walter Riso",6 , 250, 240,"la que sea", false, new Date(System.currentTimeMillis() - 172800000), new Date(System.currentTimeMillis() + 172800000)));
        libroList.add(new Libro(3, "El sol y la Arcilla", "María Lopez",10 , 2018, 300,"Ediciones Andinas", true, new Date(System.currentTimeMillis() - 172800000), new Date(System.currentTimeMillis() + 259200000)));
        libroList.add(new Libro(4, "Camino de vida", "Juan Parez",12 , 2020, 190,"Editorial Terracota", false, new Date(System.currentTimeMillis() - 172800000), new Date(System.currentTimeMillis() + 172800000)));
        libroList.add(new Libro(5, "Ama y no sufras", "Walter Riso",6 , 2015, 350,"la que sea", false, new Date(System.currentTimeMillis() - 172800000), new Date(System.currentTimeMillis() + 172800000)));

    }

    public static List<Libro> getLibroList() {
        return libroList;
    }

    public static void anadirLibro(Libro libro) {
        libroList.add(libro);
    }
}
