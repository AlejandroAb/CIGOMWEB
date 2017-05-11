/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.ArchivoObj;
import bobjects.AssemblyObj;
import bobjects.Metagenoma;
import bobjects.StatsObj;
import database.Transacciones;
import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class MetagenomaDAO {

    private Transacciones transacciones;

    public MetagenomaDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    /**
     * Este método trae la información de los metagenomas a ser desplegada en la
     * página de Blast
     *
     * @param where
     * @return
     */
    public ArrayList<ArrayList<String>> getMetagenomasBlast(String where) {
        ArrayList<ArrayList<String>> metagenomas = transacciones.getMetagenomasBlast(where);
        if (metagenomas != null && !metagenomas.isEmpty()) {
            return metagenomas;
        } else {
            return null;
        }
    }

    /**
     * Método para inicializar un metagenoma
     *
     * @param idM el id del metagenoma a inicializar
     * @return
     */
    public Metagenoma initMetagenoma(int idM) {
        Metagenoma metagenoma = new Metagenoma(idM);
        ArrayList<ArrayList> metagenomaAL = transacciones.getMetagenoma("" + idM);
        if (metagenomaAL != null && metagenomaAL.size() > 0) {
            ArrayList<String> meta = metagenomaAL.get(0);
            if (meta.size() < 16) {
                return null;
            }
            try {
                metagenoma.setIdmuestra(Integer.parseInt(meta.get(0)));
                metagenoma.setEtiquetaMuestra(meta.get(1));
            } catch (NumberFormatException nfe) {
                metagenoma.setIdmuestra(-1);
                metagenoma.setEtiquetaMuestra("Muestra desconocida");
            }
            metagenoma.setName(meta.get(2));
            metagenoma.setDesc(meta.get(3));
            metagenoma.setCultivo(meta.get(4));
            try {
                metagenoma.setLatitud(Double.parseDouble(meta.get(5)));
            } catch (NumberFormatException nfe) {
                metagenoma.setLatitud(-1);
            }
            try {
                metagenoma.setLongitud(Double.parseDouble(meta.get(6)));
            } catch (NumberFormatException nfe) {
                metagenoma.setLongitud(-1);
            }
            metagenoma.setTipoSecuenciacion(meta.get(7));
            metagenoma.setDescTipoSecuenciacion(meta.get(8));
            metagenoma.setEquipoSecuenciacion(meta.get(9));
            metagenoma.setCantidad_dna(meta.get(10));
            metagenoma.setKit(meta.get(11));
            metagenoma.setMetodo(meta.get(12));
            metagenoma.setLibrary_selection(meta.get(13));
            metagenoma.setLibrary_layout(meta.get(14));
            metagenoma.setComentarios(meta.get(15));

            int stats;
            try {
                stats = Integer.parseInt(meta.get(16));
            } catch (NumberFormatException nfe) {
                stats = -1;
            }
            StatsDAO sdao = new StatsDAO(transacciones);
            StatsObj s = sdao.initStats(stats);
            metagenoma.setStats(s);

            //EnsambleObj ensamble
            int statsAss;
            try {
                statsAss = Integer.parseInt(meta.get(17));
            } catch (NumberFormatException nfe) {
                statsAss = -1;
            }
            AssemblyDAO adao = new AssemblyDAO(transacciones);
            AssemblyObj ensamble = adao.initAssembly(statsAss);
            metagenoma.setEnsamble(ensamble);
            ArrayList<ArrayList<String>> ids = transacciones.getArchivosMetagenoma(""+idM);
            ArchivoDAO archivoDAO =  new ArchivoDAO(transacciones);
            if (ids != null) {
                for (ArrayList<String> id : ids) {
                    try {
                        ArchivoObj arch = archivoDAO.initArchivo(Integer.parseInt(id.get(0)));
                        if (arch != null) {
                            metagenoma.addArchivo(arch);
                        }
                    } catch (NumberFormatException nfe) {

                    }
                }
            }
        }
        return metagenoma;

    }
}
