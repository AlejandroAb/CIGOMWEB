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
public class Genoma {

    private int idgenoma;
    private String etiquetaMuestra;
    private int idmuestra;
    private String tax_id;
    private int idtipo_secuenciacion;
    private int idSecuenciador;
    private String tipoSecuenciacion;
    private String descTipoSecuenciacion;
    private String equipoSecuenciacion;
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
    private double latitud;
    private double longitud;
    private String cantidad_dna;
    private String metodo;
    private String kit;
    private StatsObj stats;
    private AssemblyObj ensamble;
    ArrayList<ArchivoObj> archivos = new ArrayList<>();
    

    public AssemblyObj getEnsamble() {
        return ensamble;
    }

    public void setEnsamble(AssemblyObj ensamble) {
        this.ensamble = ensamble;
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

    public StatsObj getStats() {
        return stats;
    }

    public void setStats(StatsObj stats) {
        this.stats = stats;
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

    public String getCantidad_dna() {
        return cantidad_dna;
    }

    public void setCantidad_dna(String cantidad_dna) {
        this.cantidad_dna = cantidad_dna;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public String getKit() {
        return kit;
    }

    public void setKit(String kit) {
        this.kit = kit;
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
    public String getTax_id() {
        return tax_id;
    }

    public void setTax_id(String tax_id) {
        this.tax_id = tax_id;
    }
    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }
    private String library_vector;
    private String finishing_strategy;
    private String version;

    public int getIdgenoma() {
        return idgenoma;
    }

    public Genoma(int idgenoma) {
        this.idgenoma = idgenoma;
    }

    public String getEtiquetaMuestra() {
        return etiquetaMuestra;
    }

    public void setEtiquetaMuestra(String etiquetaMuestra) {
        this.etiquetaMuestra = etiquetaMuestra;
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
