/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author Alejandro
 */
//import database.Conexion;
//import java.sql.SQLException;
import bobjects.EstacionObj;
import bobjects.Muestreo;
import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class Transacciones {

    Conexion conexion;
    boolean estamosConectados = true;
    String tipoConexion = "";
    private String database;
    private String user;
    private String ip;
    private String password;
    private String query;
    private boolean debug = false;

    public Conexion getConexion() {
        return conexion;
    }

    public Transacciones() {
        conecta(true);
    }

    public Transacciones(boolean local) {
        conecta(local);
    }

    public Transacciones(String database, String user, String ip, String password) {
        this.database = database;
        this.user = user;
        this.ip = ip;
        this.password = password;
        conecta(true);
    }

    public boolean estamosConectados() {
        return estamosConectados;
    }

    public void setEstamosConectados(boolean estamosConectados) {
        this.estamosConectados = estamosConectados;
    }

    public void desconecta() {
        conexion.shutDown();
    }

    public String getDatabase() {
        return database;
    }

    public void setDatabase(String database) {
        this.database = database;
    }

    public String getIp() {
        return ip;
    }

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public ArrayList getGenSwissProtDetailsNoTaxaInfo(String gen_id) {
        String query = "SELECT s.uniprot_id, prot_name, gene_name "
                + "FROM gen_swiss_prot AS gsp "
                + "INNER JOIN swiss_prot AS s on s.uniprot_id = gsp.uniprot_id "
                + "WHERE gen_id ='" + gen_id + "'";
        conexion.executePreparedGene(gen_id);
        return conexion.getTabla();
    }

    /**
     * Trae los detalles de un swiss prot para una predicción dada en la
     * relacion gen_swiss_prot Es usado al crear el resultado de blast mientras
     * se lee el archivo out.txt
     *
     * @param gen_id
     * @return
     */
    public ArrayList getGenSwissProtDetails(String gen_id) {
        String query = "SELECT sp.uniprot_id, uniprot_acc, prot_name, eval, name, gene_name "
                + "FROM gen_swiss_prot AS gsp  "
                + "INNER JOIN swiss_prot AS sp on sp.uniprot_id = gsp.uniprot_id "
                + "INNER JOIN ncbi_node ON sp.ncbi_tax_id = ncbi_node.tax_id "
                + "WHERE gsp.gen_id ='" + gen_id + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     * Trae los detalles (tipo de muestra y profundidad) para una muestra dado
     * un gen predicho en un metagenoma
     *
     * @param gen_id
     * @param meta si es para metagenoma tiene que venir la palabra "meta" para
     * genomas, vacio.
     * @return
     */
    public ArrayList getDetallesMuestraByGen(String gen_id, String meta) {
        String query = "SELECT tipo_muestra, muestreo.profundidad  "
                + "FROM gen "
                + "INNER JOIN " + meta + "genoma ON " + meta + "genoma.id" + meta + "genoma = gen.id" + meta + "genoma "
                + "INNER JOIN muestra ON muestra.idmuestra = " + meta + "genoma.idmuestra "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN tipo_muestra ON tipo_muestra.idtipomuestra = muestreo.idtipomuestra "
                + "WHERE gen.gen_id = '" + gen_id + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public void conecta(boolean conex) {
        if (conex) {
            // ArchivoIP aip = new ArchivoIP();
            //String[]config =  aip.obtieneIP();
            // conexion = new Conexion(config[1], config[0]);
            conexion = new Conexion(database, ip, user, password);
            //System.out.println(config[1] + "  " + config[0]);
            //  JOptionPane.showMessageDialog(null, config[1],config[0],JOptionPane.INFORMATION_MESSAGE);
            estamosConectados = conexion.seConecto;
            tipoConexion = "remota";
        } else {
            //conexion = new Conexion("mantenimiento", "localhost");
            // conexion = new Conexion("bio", "localhost", "root", "AMORPHIS");
            estamosConectados = conexion.seConecto;
            tipoConexion = "local";
        }
    }

    /**
     * Trae la información básica de un usuario
     *
     * @param idUser
     * @return
     */
    public ArrayList getUser(int idUser) {
        String query = "SELECT nombres, apellidos, correo, terminos FROM usuario WHERE idUsuario = " + idUser;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     * Este query se encarga de traer una lista con el id y el nombre de los
     * sitios que fueron muestreados en una campaña. Un derrotero puede tener
     * estaciones mas no siempre existen muestreos en dicha estación. Este
     * método es usado en CampanaDAO para obtener un resumen de la campana
     *
     * @param idCampana el id de la campaña de la cual necesitamos saber las
     * estaciones muestreadas
     * @return
     */
    public ArrayList getEstacionesMuestreadasFromCampana(int idCampana) {
        String query = " SELECT distinct estacion.idEstacion, estacion_nombre "
                + "FROM estacion INNER JOIN muestreo  ON  muestreo.idEstacion = estacion.idEstacion  "
                + "WHERE idCampana = " + idCampana;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     * Este método se encarga de traer información complementaria al gen, es
     * usado para mostrar el resultado de blast
     *
     * @param gen_id
     * @return
     */
    public ArrayList getInfoComplementariaGenMetagenoma(String gen_id) {
        String query = " SELECT sp.uniprot_id, uniprot_acc, prot_name,ncbi_node.name,tipo_muestra,eval "
                + "FROM gen LEFT JOIN gen_swiss_prot as gsp on gsp.gen_id = gen.gen_id "
                + "LEFT JOIN swiss_prot as sp on sp.uniprot_id = gsp.uniprot_id "
                + "LEFT JOIN ncbi_node on sp.ncbi_tax_id = ncbi_node.tax_id "
                + "INNER JOIN metagenoma ON metagenoma.idmetagenoma = gen.idmetagenoma "
                + "INNER JOIN muestra on muestra.idmuestra = metagenoma.idmuestra "
                + "INNER JOIN muestreo on muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN tipo_muestra on tipo_muestra.idtipomuestra = muestreo.idtipomuestra "
                + "WHERE gen.gen_id = '" + gen_id + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public void compilePreparedGene() {
        conexion.compilePreparedGene();
    }

    public ArrayList executePreparedGene(String gen_id) {
        conexion.executePreparedGene(gen_id);
        return conexion.getTabla();
    }

    public ArrayList executePreparedMetaGene(String gen_id) {
        conexion.executePreparedMetaGene(gen_id);
        return conexion.getTabla();
    }

    /**
     * Este query se encarga de traer una lista con el id y el nombre de los
     * sitios que fueron muestreados en una campaña. Un derrotero puede tener
     * estaciones mas no siempre existen muestreos en dicha estación. Este
     * método es usado en CampanaDAO para obtener un resumen de la campana
     *
     * @param idCampana el id de la campaña de la cual necesitamos saber las
     * estaciones muestreadas
     * @return
     */
    public ArrayList getEstacionesMuestreadasFromCampana2Map(int idCampana) {
        String query = " SELECT distinct estacion.idestacion, estacion_nombre, estacion.latitud, estacion.longitud "
                + "FROM estacion INNER JOIN muestreo ON estacion.idestacion = muestreo.idEstacion "
                + "WHERE muestreo.idcampana =" + idCampana;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     * Trae una llista de todas las campañas en la BD, las trae ordenadas por
     * fecha de término, de esta manera siempre la primera en desplegarse es la
     * última campaña realizada
     *
     * @return
     */
    public ArrayList getAllCampanas() {
        String query = "SELECT idcampana, siglas, nombre FROM campana order by fecha_termino desc";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public ArrayList getSequenceWithProtInfo(String genIDList, String seqType) {
        String query = "SELECT DISTINCT gen.gen_id, gen_src, sequence, gen_strand, seq_from, "
                + "seq_to,gsp.uniprot_id, prot_name, gene_name "
                + "FROM gen "
                + "INNER JOIN gen_seq on gen_seq.gen_id = gen.gen_id "
                + "LEFT JOIN gen_swiss_prot as gsp on gsp.gen_id = gen_seq.gen_id "
                + "LEFT JOIN swiss_prot as s on s.uniprot_id = gsp.uniprot_id "
                + "WHERE gen.gen_id in(" + genIDList + ") "
                + "AND seq_type = '" + seqType + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public ArrayList getSequenceWithoutProtInfo(String genIDList, String seqType) {
        String query = "SELECT DISTINCT gen.gen_id, gen_src, sequence, gen_strand, seq_from, seq_to "
                + "FROM gen "
                + "INNER JOIN gen_seq on gen_seq.gen_id = gen.gen_id "
                + "WHERE gen.gen_id in(" + genIDList + ") "
                + "AND seq_type = '" + seqType + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     *
     * @param idUsuario
     * @return
     */
    public ArrayList getBlastJobsByUser(int idUsuario) {
        String query = "SELECT idblast_job, job_url FROM blast_job  "
                + "WHERE idusuario = " + idUsuario
                + " ORDER BY start_date desc";
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public ArrayList getBlastMetaDbs(String blastJob) {
        String query = "SELECT bjm.idmetagenoma, meta_name "
                + "FROM blast_job_metagenoma AS bjm "
                + "INNER JOIN metagenoma ON metagenoma.idmetagenoma = bjm.idmetagenoma "
                + "WHERE bjm.idblast_job = " + blastJob;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public ArrayList getBlastGenoDbs(String blastJob) {
        String query = "SELECT bjg.idgenoma, genome_name "
                + "FROM blast_job_genoma AS bjg "
                + "INNER JOIN genoma ON genoma.idgenoma = bjg.idgenoma "
                + "WHERE bjg.idblast_job = " + blastJob;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public boolean deleteBlastJob(String idJob) {
        String query = "DELETE FROM blast_job WHERE idblast_job = " + idJob;
        return conexion.queryUpdate(query);
    }

    public boolean deleteBlastMetaBase(String idJob) {
        String query = "DELETE FROM blast_job_metagenoma WHERE idblast_job = " + idJob;
        return conexion.queryUpdate(query);
    }

    public boolean deleteBlastGenoBase(String idJob) {
        String query = "DELETE FROM blast_job_genoma WHERE idblast_job = " + idJob;
        return conexion.queryUpdate(query);
    }

    /**
     * Trae la información de todos los genomas dada una consición
     *
     * @param where
     * @return
     */
    public ArrayList getGenomas(String where) {
        String query = "SELECT * from genoma " + where;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    public ArrayList getMetagenomas(String where) {
        String query = "SELECT * from metagenoma " + where;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    /**
     * Trae la información de los metagenomas cuando son presentados en la tabla
     * para seleccionar el target en la página de blast
     *
     * @param where
     * @return
     */
    public ArrayList getMetagenomasBlast(String where) {
        String query = " SELECT idmetagenoma, meta_name, tipo_muestra, estacion_nombre "
                + "FROM metagenoma INNER JOIN muestra ON muestra.idmuestra = metagenoma.idmuestra "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN tipo_muestra ON tipo_muestra.idtipomuestra = muestreo.idtipomuestra  "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "INNER JOIN estacion on estacion.idestacion = derrotero.idestacion "
                + where;
        conexion.executeStatement(query);
        return conexion.getTabla();
//+ "WHERE seq_num_total > 0";
    }

    /**
     * Trae la información de los Genomas cuando son presentados en la tabla
     * para seleccionar el target en la página de blast
     *
     * @param where
     * @return
     */
    public ArrayList getGenomasBlast(String where) {
        String query = "SELECT idgenoma, genome_name, name, estacion_nombre "
                + "FROM genoma INNER JOIN muestra ON muestra.idmuestra = genoma.idmuestra "
                + "INNER JOIN ncbi_node ON ncbi_node.tax_id = genoma.tax_id  "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "INNER JOIN estacion on estacion.idestacion = derrotero.idestacion "
                //Quizas poner un inner join con genes para asegurar que no sean genomas vacios
                + where;
        conexion.executeStatement(query);
        return conexion.getTabla();
//+ "WHERE seq_num_total > 0";
    }

    /**
     * Autentica un usuario en la BD
     *
     * @param user
     * @param pass
     * @return
     */
    public int authentUser(String user, String pass) {
        String query = "SELECT idusuario "
                + "FROM usuario WHERE correo='" + user + "' AND password=MD5('" + pass + "')";

        conexion.executeStatement(query);
        //   System.out.println(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return id;
    }

    /**
     * Trae el id de la campana mas reciente, es usado en el home para mostrar
     * la útima campaña por default
     *
     * @return
     */
    public int getLastIDCampana() {
        String query = "SELECT idcampana "
                + "FROM campana ORDER BY fecha_termino DESC";

        conexion.executeStatement(query);
        //   System.out.println(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return id;
    }

    public int createJob(int idUsuario, String jobName, String jobUrl, String job_type, double eval, String path, String host, String status, String message) {
        String query = "INSERT INTO blast_job (idblast_job, idUsuario, job_name, job_url, job_type, eval, path, host, "
                + "start_date, end_date, status, message) "
                + "values(0," + idUsuario + ",'" + jobName + "','" + jobUrl + "','" + job_type + "'," + eval + ",'" + path + "','" + host
                + "',NOW(), NULL, '" + status + "','" + message + "')";
        return conexion.queryUpdateWithKey(query);
    }

    /**
     * Obtiene cual es el max id de muestro para poder asignar nuevos ya que no
     * esta declarado como auto_increment
     *
     * @return
     */
    public int getMaxIDMuestreo() {
        String query = "SELECT MAX(idMuestreo) FROM muestreo";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return ++id;

    }

    /**
     * Este query trae el conteo de muestreos (no muetsras) realizadas en una
     * estacion para cierta campaña y un tipo de muestra dado. Este query sirve
     * de apoyo para construir la tabla de resumen de camaña mostrada en home
     * usado en CampanaDao.getResumenCampana
     *
     * @param idCampana
     * @param idEstacion
     * @param idTipoMuestra
     * @return
     */
    public int getConteoMuestreosCampanaEstacionTipoMuestra(int idCampana, int idEstacion, int idTipoMuestra) {
        String query = "SELECT count(idMuestreo) FROM muestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE derrotero.idcampana = " + idCampana + " AND derrotero.idEstacion = " + idEstacion
                + " AND idTipomuestra = " + idTipoMuestra;
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;
    }

    /**
     * Este query trae el conteo de muestreos (no muetsras) realizadas en una
     * estacion para cierta campaña y un tipo de muestra dado. Este query sirve
     * de apoyo para construir la tabla de resumen de camaña mostrada en home
     * usado en CampanaDao.getResumenCampana
     *
     * @param idCampana
     * @param idEstacion
     * @param tipoProfundidad
     * @return
     */
    public int getConteoMuestreosCampanaEstacionTipoProfundidad(int idCampana, int idEstacion, String tipoProfundidad) {
        /*  String query = "SELECT count(idMuestreo) FROM muestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE derrotero.idcampana = " + idCampana + " AND derrotero.idEstacion = " + idEstacion
                + " AND tipo_profundidad = '" + tipoProfundidad + "'";*/
        String query = "SELECT count(idMuestreo) FROM muestreo "
                // + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE idcampana = " + idCampana + " AND idEstacion = " + idEstacion
                + " AND tipo_profundidad = '" + tipoProfundidad + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;

    }

    /**
     * Este query trae el conteo de amplicones realizados de una muestra de una
     * estacion para cierta campaña y un tipo de profundidad. Este query sirve
     * de apoyo para construir la tabla de resumen de camaña mostrada en home
     * usado en CampanaDao.getResumenCampanaRegistro
     *
     * @param idCampana la campaña
     * @param idEstacion la estacion
     * @param tipoProfundidad el tipo de profundidad muestreada: FONDO, MAX_F,
     * MIL, MIN_O, SED
     * @return
     */
    public int getConteoAmpliconesCampanaEstacionTipoProfundidad(int idCampana, int idEstacion, String tipoProfundidad) {
        String query = "SELECT COUNT(idmarcador) FROM marcador "
                + "INNER JOIN muestra ON muestra.idmuestra = marcador.idmuestra "
                + "INNER JOIN muestreo on muestreo.idmuestreo = muestra.idmuestreo "
                //   + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE idcampana = " + idCampana + " AND idEstacion = " + idEstacion
                + " AND tipo_profundidad = '" + tipoProfundidad + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;

    }

    /**
     * Este query trae el conteo de metagenomas realizados de una muestra de una
     * estacion para cierta campaña y un tipo de profundidad. Este query sirve
     * de apoyo para construir la tabla de resumen de camaña mostrada en home
     * usado en CampanaDao.getResumenCampanaRegistro
     *
     * @param idCampana la campaña
     * @param idEstacion la estacion
     * @param tipoProfundidad el tipo de profundidad muestreada: FONDO, MAX_F,
     * MIL, MIN_O, SED
     * @return
     */
    public int getConteoMetagenomasCampanaEstacionTipoProfundidad(int idCampana, int idEstacion, String tipoProfundidad) {
        String query = "SELECT COUNT(idmetagenoma) FROM metagenoma "
                + "INNER JOIN muestra ON muestra.idmuestra = metagenoma.idmuestra "
                + "INNER JOIN muestreo on muestreo.idmuestreo = muestra.idmuestreo "
                //      + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE idcampana = " + idCampana + " AND idEstacion = " + idEstacion
                + " AND tipo_profundidad = '" + tipoProfundidad + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;

    }

    /**
     * Este query trae el conteo de genomas realizados de una muestra de una
     * estacion para cierta campaña y un tipo de profundidad. Este query sirve
     * de apoyo para construir la tabla de resumen de camaña mostrada en home
     * usado en CampanaDao.getResumenCampanaRegistro
     *
     * @param idCampana la campaña
     * @param idEstacion la estacion
     * @param tipoProfundidad el tipo de profundidad muestreada: FONDO, MAX_F,
     * MIL, MIN_O, SED
     * @return
     */
    public int getConteoGenomasCampanaEstacionTipoProfundidad(int idCampana, int idEstacion, String tipoProfundidad) {
        String query = "SELECT COUNT(idgenoma) FROM genoma "
                + "INNER JOIN muestra ON muestra.idmuestra = genoma.idmuestra "
                + "INNER JOIN muestreo on muestreo.idmuestreo = muestra.idmuestreo "
                //   + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE idcampana = " + idCampana + " AND idEstacion = " + idEstacion
                + " AND tipo_profundidad = '" + tipoProfundidad + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;
    }

    /**
     * Este método trae el conteo de metagenomas en una estación para una
     * campaña en específico. Este query es usado para onstruir la tabla del
     * resumen en el home de la app
     *
     * @param idCampana
     * @param idEstacion
     * @return
     */
    public int getConteoMetagenomasPorEstacionCampana(int idCampana, int idEstacion) {
        String query = "SELECT COUNT(idMetagenoma) FROM metagenoma "
                + "INNER JOIN muestra ON muestra.idMuestra = metagenoma.idMuestra "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE derrotero.idcampana = " + idCampana + " AND derrotero.idEstacion = " + idEstacion;
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;
    }

    /**
     * Este método trae el conteo de genomas en una estación para una campaña en
     * específico. Este query es usado para construir valores en la tabla del
     * resumen en el home de la app
     *
     * @param idCampana
     * @param idEstacion
     * @return
     */
    public int getConteoGenomaPorEstacionCampana(int idCampana, int idEstacion) {
        String query = "SELECT COUNT(idgenoma) FROM genoma "
                + "INNER JOIN muestra ON muestra.idMuestra = genoma.idMuestra "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE derrotero.idcampana = " + idCampana + " AND derrotero.idEstacion = " + idEstacion;
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;
    }

    /**
     * Este método trae el conteo de amplicones en una estación para una campaña
     * en específico. Este query es usado para construir valores en la tabla del
     * resumen en el home de la app
     *
     * @param idCampana
     * @param idEstacion
     * @return
     */
    public int getConteoAmpliconPorEstacionCampana(int idCampana, int idEstacion) {
        String query = "SELECT COUNT(idMarcador) FROM marcador "
                + "INNER JOIN muestra ON muestra.idMuestra = marcador.idMuestra "
                + "INNER JOIN muestreo ON muestreo.idmuestreo = muestra.idmuestreo "
                + "INNER JOIN derrotero ON derrotero.idderrotero = muestreo.idCE "
                + "WHERE derrotero.idcampana = " + idCampana + " AND derrotero.idEstacion = " + idEstacion;
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int count;
        if (dbResult == null || dbResult.isEmpty()) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                count = 0;
            }
        }
        return count;
    }

    /**
     * Obtiene cual es el max id de muestra para poder asignar nuevos.
     *
     * @return
     */
    public int getMaxIDMuestra() {
        String query = "SELECT MAX(idMuestra) FROM muestra";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return ++id;

    }

    /**
     * Recibe un objeto de tipo estacion y en base a su nombe ve si este existe
     * si no existe, la estacion es creada en la BD
     *
     * @param est
     * @return
     */
    public int testEstacionByName(EstacionObj est) {
        String query = "SELECT idEstacion from estacion WHERE estacion_nombre = '" + est.getNombre() + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            query = "INSERT INTO estacion(idEstacion, estacion_nombre, id_tipo_estacion, longitud, latitud, comentarios) "
                    + "VALUES(0,'" + est.getNombre() + "'," + est.getTipo_est() + "," + est.getLongitud().getCoordenadas()
                    + "," + est.getLatitud().getCoordenadas() + ",'" + est.getComentarios() + "')";
            id = conexion.queryUpdateWithKey(query);
            query = "INSERT INTO estacion_tipo_estacion VALUES(" + id + "," + est.getTipo_est() + ")";
            conexion.queryUpdate(query);
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return id;
    }

    /**
     * Recibe un objeto de tipo estacion y en base a su nombe ve si este existe
     * A diferencia del otro testEstacionByName pero con param Estacion, este
     * solo verifica y regresa el ID, no inserta nada a la BD
     *
     * @param est
     * @return
     */
    public int testEstacionByName(String est) {
        String query = "SELECT idEstacion from estacion WHERE estacion_nombre = '" + est + "'";
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return id;

    }

    /**
     * Esste metodo se encarga de obtener el ID del derrotero es decir la
     * convinación estacion y campaña. Es usado durante la carga de los
     * muestreos, dado que este es el ID que se relaciona con el muestreo. El
     * único problema es que si se visita mas de una vez la misma estación en
     * una sola campaña este método tiende aa fallar por lo que hay que hacer
     * uso de la fecha o algún otro campo para realizar la correcta validación.
     *
     * @param idEst id de la estación
     * @param idCampana id de la campaña.
     * @return
     */
    public int getIDDerrotero(int idEst, int idCampana) {
        String query = "SELECT idDerrotero from derrotero "
                + "WHERE idEstacion = " + idEst + " AND idCampana = " + idCampana;
        conexion.executeStatement(query);
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        int id = -1;
        if (dbResult == null || dbResult.isEmpty()) {
            id = -1;
        } else {
            try {
                id = Integer.parseInt((String) dbResult.get(0).get(0));
            } catch (NumberFormatException nfe) {
                id = -1;
            }
        }
        return id;

    }

    public int insertaDerrotero(int idCampana, int idEstacion, String nombre, String fPlaneada, String fEjecutada, int numEstP, int numEstE, String comentarios) {
        String query = "INSERT INTO derrotero "
                + "VALUES(0," + idCampana + "," + idEstacion + ",'" + nombre + "'," + fPlaneada + "," + fEjecutada
                + "," + numEstP + "," + numEstE + ",'" + comentarios + "')";
        return conexion.queryUpdateWithKey(query);
    }

    public boolean testConnection() {
        String query = "select 1";
        conexion.executeStatement(query);
        //Vector paraRegresar = conexion.getFilas();
        ArrayList<ArrayList> dbResult = conexion.getTabla();

        //if (paraRegresar.size() > 0) {
        if (dbResult != null && dbResult.size() > 0) {
            try {
                // return ( (Vector) paraRegresar.elementAt(0)).elementAt(
                //    0).toString();
                return true;
            } catch (NullPointerException npe) {
                return false;
            }
        } else {
            return false;
        }

    }

    public boolean updateHierarchyNCBINode(String taxid, String hierarchy) {
        String query = "UPDATE NCBI_NODE SET hierarchy = '" + hierarchy + "' WHERE tax_id =" + taxid;
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            System.out.println(conexion.getLog());
            return false;
        }
    }

    public boolean insertJobIDMetagenoma(int idJob, String idmetagenoma) {
        String query = "INSERT INTO blast_job_metagenoma VALUES(" + idmetagenoma + ", " + idJob + ")";
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            System.out.println(conexion.getLog());
            return false;
        }
    }

    public boolean insertJobIDGenoma(int idJob, String idgenoma) {
        String query = "INSERT INTO blast_job_genoma VALUES(" + idgenoma + ", " + idJob + ")";
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            System.out.println(conexion.getLog());
            return false;
        }
    }

    /**
     * since: GCT3 NG Metodo para actualizar el status de un job
     *
     * @param jobID
     * @param status
     * @param withDate
     * @return
     */
    public boolean updateJobStatus(String jobID, String status, String msg, boolean withDate) {
        String query;
        if (withDate) {
            query = "UPDATE blast_job set status = '" + status + "', message = '" + msg + "', end_date = NOW() WHERE idblast_job = " + jobID;
        } else {
            query = "UPDATE blast_job set status = '" + status + "', message = '" + msg + "' WHERE idblast_job = " + jobID;
        }
        System.out.println(query);
        return conexion.queryUpdate(query);
    }

    /**
     * Este metodo se encarga de traer la info necesario para inicializar un job
     * a partir de un user id o url que es el "link" que se le genera al usuario
     * para visualizar el job.
     *
     * @param uId ID que tiene el link del usuario para accesar al job
     * @return
     */
    public ArrayList<ArrayList> getJobDetails(String uId) {
        String query = "SELECT idblast_job, job_name, job_type, eval,  start_date, end_date, status, message, path "
                + "FROM blast_job "
                + "WHERE job_url = '" + uId + "'";
        conexion.executeStatement(query);
        //Vector paraRegresar = conexion.getFilas();
        ArrayList<ArrayList> dbResult = conexion.getTabla();
        return dbResult;
    }

    public boolean insertJobIDMGenoma(String idJob, String idgenoma) {
        String query = "INSERT INTO blast_job VALUES(" + idgenoma + ", " + idJob + ")";
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            System.out.println(conexion.getLog());
            return false;
        }
    }

    public boolean insertaQuery(String query) {
        if (debug) {
            System.out.println(query);
        }
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            System.out.println(conexion.getLog());
            return false;
        }

    }

    public boolean insertSwissProt(String uniprotID, String uniprotACC, String taxID, String uniprotName, String sequence, int seqLength, String clusterId, String clusterName, String clusterTax) {
        String query = "INSERT INTO Swiss_prot (uniprot_id, uniprot_acc, ncbi_tax_id, "
                + "prot_name, prot_seq, prot_length, cluster_id, cluster_name, cluster_ncbi_tax) VALUES ('"
                + uniprotID + "', '"
                + uniprotACC + "', '"
                + taxID + "', '"
                + uniprotName + "', '"
                + sequence + "', "
                + seqLength + ", '"
                + clusterId + "', '"
                + clusterName + "', '"
                + clusterTax + "');\n";
        if (debug) {
            System.out.println(query);
        }
        return conexion.queryUpdate(query);
    }

    public boolean writeFastaFileByOrg(String orgID, String seqType, String extra, String fileName) {
        String query = " SELECT DISTINCT(CONCAT('>',seq_gen_id,char(10),seq_seq)) "
                + "FROM gen_seq "
                + "WHERE seq_org = '" + orgID + "' "
                + "AND seq_type = '" + seqType + "' "
                + " " + extra
                + " INTO OUTFILE '" + fileName + "'"
                + "FIELDS ESCAPED BY ''";

        //Vector paraRegresar = conexion.getFilas();
        //return conexion.queryUpdate(query);
        conexion.executeStatementToFile(query);
        return true;
    }

    ///METODO PARA MOSTRAR EL NOMBRE SELECCIONADO DE LA CAMPAÑA EN EL HOME
    public ArrayList getAllCampanasId(int idCampana) {
        String query = "SELECT idcampana, siglas, nombre FROM campana where idcampana=" + idCampana;
        conexion.executeStatement(query);
        return conexion.getTabla();
    }

    ///METODO PARA ACTUALIZAR TERMINO DE UN SUARIO AL ENTRAR AL SISTEMA
    public boolean updateTerminos(String user) {

        String query = "update usuario set terminos=1 where correo='" + user + "'";
        if (conexion.queryUpdate(query)) {
            return true;
        } else {
            // System.out.println(conexion.getLog());
            return false;
        }

    }

    /**
     * Este metodo se encarga de traer la info necesario para inicializar una
     * muestra a partir de una etiqueta url que es el "link" que se le genera al
     * usuario para visualizar la muestra.
     *
     * @param url ID que tiene el link del usuario para accesar al job
     * @return
     */
    public ArrayList getMuestra(int idMuestra) {
        String query = "SELECT idMuestra,etiqueta,contenedor,tamano,protocolo,notas,rel_to_oxygen,contenedor_temp "
                + "FROM muestra "
                + "WHERE idMuestra = '" + idMuestra + "'";
        conexion.executeStatement(query);
        return conexion.getTabla();

    }

    public ArrayList getMuestreo(int idMuestra) {
        String query = "SELECT idMuestra,muestreo.etiqueta,nombre,estacion_nombre,bioma,env_material,env_feature,muestreo.protocolo,latitud_r,longitud_r,latitud as latitud_estacion,longitud as longitud_estacion "
                + "FROM muestreo "
                + "INNER JOIN campana on campana.idCampana=muestreo.idCampana "
                + "INNER JOIN estacion on estacion.idEstacion=muestreo.idEstacion "
                + "INNER JOIN muestra on muestra.idMuestreo = muestreo.idMuestreo "
                + "WHERE idMuestra= " + idMuestra + "";
        conexion.executeStatement(query);
        return conexion.getTabla();

    }

    public ArrayList getVariables(int idMuestra) {
        String query = "SELECT muestreo.idMuestreo,mv.idvariable, nombre_web, medicion_t1, unidades "
                + "FROM muestreo_variable as mv  "
                + "inner join variable on variable.idvariable = mv.idvariable "
                + "inner join muestreo on muestreo.idMuestreo= mv.idMuestreo "
                + "inner join muestra on muestra.idMuestreo = muestreo.idMuestreo "
                + "WHERE muestra.idmuestra = " + idMuestra + "";
        conexion.executeStatement(query);
        return conexion.getTabla();

    }

    public ArrayList getMuestreo2(int idMuestreo) {
        String query = "SELECT muestreo.idMuestreo,muestreo.etiqueta as etiqueta_muestreo,nombre as nombre_campana,estacion_nombre,bioma,env_material,env_feature,muestreo.protocolo as muestreo_protocolo,"
                + "muestra.protocolo as muestra_protocolo,contenedor,muestra.tamano,notas,rel_to_oxygen,contenedor_temp "
                + "FROM muestreo "
                + "INNER JOIN campana on campana.idCampana=muestreo.idCampana "
                + "INNER JOIN estacion on estacion.idEstacion=muestreo.idEstacion "
                + "INNER JOIN muestra on muestra.idMuestreo = muestreo.idMuestreo "
                + "WHERE muestreo.idMuestreo= '" + idMuestreo + "';";
        conexion.executeStatement(query);
        return conexion.getTabla();

    }

}
