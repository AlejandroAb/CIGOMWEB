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
public class Genoma {

    private int idgenoma;
    private int idmuestra;
    private int idtipo_secuenciacion;
    private int idSecuenciador;
    private NCBINode tax;
    private String name;
    private String desc;
    private String strain;
    private String crecimiento;
    private int replicones = 1;
    private String referencia;
    private String comentarios;
    private String library_selection;
    private String library_layout;
    private String library_screen;
    private String library_vector;
    private String finishing_strategy;

    public int getIdgenoma() {
        return idgenoma;
    }

    public Genoma(int idgenoma) {
        this.idgenoma = idgenoma;
    }

    public Genoma() {
    }
    
    public void setIdgenoma(int idgenoma) {
        this.idgenoma = idgenoma;
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

    public NCBINode getTax() {
        return tax;
    }

    public void setTax(NCBINode tax) {
        this.tax = tax;
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

    public String getStrain() {
        return strain;
    }

    public void setStrain(String strain) {
        this.strain = strain;
    }

    public String getCrecimiento() {
        return crecimiento;
    }

    public void setCrecimiento(String crecimiento) {
        this.crecimiento = crecimiento;
    }

    public int getReplicones() {
        return replicones;
    }

    public void setReplicones(int replicones) {
        this.replicones = replicones;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
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

    public String getFinishing_strategy() {
        return finishing_strategy;
    }

    public void setFinishing_strategy(String finishing_strategy) {
        this.finishing_strategy = finishing_strategy;
    }
    
    

}
