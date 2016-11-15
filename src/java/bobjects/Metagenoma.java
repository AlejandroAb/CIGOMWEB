/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bobjects;

/**
 *
 * @author Alejandro
 */
public class Metagenoma {

    private int idmetagenoma;
    private int idmuestra;
    private int idtipo_secuenciacion;
    private int idSecuenciador;
    private String name;
    private String desc;
    private String comentarios;
    private String library_selection;
    private String library_layout;
    private String library_screen;
    private String library_vector;
    private int seq_num_total;
    private String cantidad_dna;

    public Metagenoma(int idmetagenoma) {
        this.idmetagenoma = idmetagenoma;
    }

    public int getIdmetagenoma() {
        return idmetagenoma;
    }

    public void setIdmetagenoma(int idmetagenoma) {
        this.idmetagenoma = idmetagenoma;
    }

    public int getIdmuestra() {
        return idmuestra;
    }

    public void setIdmuestra(int idmuestra) {
        this.idmuestra = idmuestra;
    }

    public int getIdtipo_secuenciacion() {
        return idtipo_secuenciacion;
    }

    public void setIdtipo_secuenciacion(int idtipo_secuenciacion) {
        this.idtipo_secuenciacion = idtipo_secuenciacion;
    }

    public int getIdSecuenciador() {
        return idSecuenciador;
    }

    public void setIdSecuenciador(int idSecuenciador) {
        this.idSecuenciador = idSecuenciador;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public String getLibrary_selection() {
        return library_selection;
    }

    public void setLibrary_selection(String library_selection) {
        this.library_selection = library_selection;
    }

    public String getLibrary_layout() {
        return library_layout;
    }

    public void setLibrary_layout(String library_layout) {
        this.library_layout = library_layout;
    }

    public String getLibrary_screen() {
        return library_screen;
    }

    public void setLibrary_screen(String library_screen) {
        this.library_screen = library_screen;
    }

    public String getLibrary_vector() {
        return library_vector;
    }

    public void setLibrary_vector(String library_vector) {
        this.library_vector = library_vector;
    }

    public int getSeq_num_total() {
        return seq_num_total;
    }

    public void setSeq_num_total(int seq_num_total) {
        this.seq_num_total = seq_num_total;
    }

    public String getCantidad_dna() {
        return cantidad_dna;
    }

    public void setCantidad_dna(String cantidad_dna) {
        this.cantidad_dna = cantidad_dna;
    }
    
    

}
