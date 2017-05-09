/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bobjects;

import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class Metagenoma {

    private int idmetagenoma;
    private int idmuestra;
    private int idtipo_secuenciacion;
    private String tipoSecuenciacion;
    private String descTipoSecuenciacion;
    private int idSecuenciador;
    private String equipoSecuenciacion;//
    private String name;//nombre metagenoma
    private String desc;//descripcion  metagenoma
    private String comentarios;
    private String library_selection;
    private String library_layout;
    private String library_screen;
    private String library_vector;
    private int seq_num_total;
    private String cantidad_dna;
    private String metodo;
    private String cultivo;
    private String kit;
    private String etiquetaMuestra;
    private double latitud;
    private double longitud;
    private StatsObj stats;
    private AssemblyObj ensamble;
    ArrayList<ArchivoObj> archivos = new ArrayList<>();
    public StatsObj getStats() {
        return stats;
    }

    public ArrayList<ArchivoObj> getArchivos() {
        return archivos;
    }

    public void setArchivos(ArrayList<ArchivoObj> archivos) {
        this.archivos = archivos;
    }
    public void addArchivo(ArchivoObj archivo){
        archivos.add(archivo);
    }
    public AssemblyObj getEnsamble() {
        return ensamble;
    }

    public void setEnsamble(AssemblyObj ensamble) {
        this.ensamble = ensamble;
    }

    public void setStats(StatsObj stats) {
        this.stats = stats;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public String getMetodo() {
        return metodo;
    }

    public String getTipoSecuenciacion() {
        return tipoSecuenciacion;
    }

    public void setTipoSecuenciacion(String tipoSecuenciacion) {
        this.tipoSecuenciacion = tipoSecuenciacion;
    }

    public String getDescTipoSecuenciacion() {
        return descTipoSecuenciacion;
    }

    public void setDescTipoSecuenciacion(String descTipoSecuenciacion) {
        this.descTipoSecuenciacion = descTipoSecuenciacion;
    }

    public String getEquipoSecuenciacion() {
        return equipoSecuenciacion;
    }

    public void setEquipoSecuenciacion(String equipoSecuenciacion) {
        this.equipoSecuenciacion = equipoSecuenciacion;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public String getCultivo() {
        return cultivo;
    }

    public void setCultivo(String cultivo) {
        this.cultivo = cultivo;
    }

    public String getKit() {
        return kit;
    }

    public void setKit(String kit) {
        this.kit = kit;
    }

    public String getEtiquetaMuestra() {
        return etiquetaMuestra;
    }

    public void setEtiquetaMuestra(String etiquetaMuestra) {
        this.etiquetaMuestra = etiquetaMuestra;
    }

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
