/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.ArchivoObj;
import bobjects.Marcador;
import bobjects.StatsObj;
import database.Transacciones;
import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class MarcadorDAO {

    private Transacciones transacciones;

    public MarcadorDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    /**
     * Este método se encarga de inicializar un Marcador
     *
     * @param idMarcador el id del marcador a inicializar
     * @return marcador inicializado o null si no existe el id
     */
    public Marcador initMarcador(String idMarcador) {
        Marcador marcador = new Marcador(idMarcador);
        PcrDAO pcr = new PcrDAO(transacciones);
        ArchivoDAO archivoDAO = new ArchivoDAO(transacciones);
        StatsDAO stats = new StatsDAO(transacciones);
        ArrayList<ArrayList<String>> datosMarcador = transacciones.getMarcador(idMarcador);
        if (datosMarcador != null && datosMarcador.size() > 0) {
            //sólo se espera un elemento
            ArrayList<String> datos = datosMarcador.get(0);
            marcador.setIdMuestra(datos.get(1));
            marcador.setEtiquetaMuestra(datos.get(2));
            marcador.setIdTipoMarcador(datos.get(3));
            marcador.setGenes(datos.get(4));
            marcador.setSubFragment(datos.get(5));
            marcador.setIdTipoSec(datos.get(6));
            marcador.setNombreTipoSecuenciacion(datos.get(7));
            marcador.setDescripcionTipoSecuenciacion(datos.get(8));
            marcador.setIdSecuenciador(datos.get(9));
            marcador.setMarca(datos.get(10));
            marcador.setModelo(datos.get(11));
            marcador.setIdPcr(datos.get(12));
            try {
                int idPCR = Integer.parseInt(datos.get(12));
                marcador.setPcr(pcr.initPCR(idPCR));
            } catch (NumberFormatException nfe) {
                marcador.setPcr(null);
            }

            marcador.setMarc_name(datos.get(13));
            marcador.setMarc_desc(datos.get(14));
            try {
                int tmp = Integer.parseInt(datos.get(15));
                marcador.setSeq_num_total(tmp);
            } catch (NumberFormatException nfe) {
                marcador.setSeq_num_total(-1);
            }
            marcador.setLibrary_selection(datos.get(16));
            marcador.setLibrary_layout(datos.get(17));
            marcador.setLibrary_vector(datos.get(18));
            marcador.setRaw_data_path(datos.get(19));
            marcador.setProc_data_path(datos.get(20));
            marcador.setPre_process(datos.get(21));
            marcador.setData_qc(datos.get(22));
            marcador.setIdStats(datos.get(23));
            try {
                int tmp = Integer.parseInt(datos.get(23));
                marcador.setStats(stats.initStats(tmp));
            } catch (NumberFormatException nfe) {
                marcador.setStats(new StatsObj(-1));
            }
            marcador.setVolumen(datos.get(24));
            marcador.setComentarios(datos.get(25));
            ArrayList<ArrayList<String>> ids = transacciones.getArchivosMarcador(idMarcador);
            if (ids != null) {
                for (ArrayList<String> id : ids) {
                    try {
                        ArchivoObj arch = archivoDAO.initArchivo(Integer.parseInt(id.get(0)));
                        if (arch != null) {
                            marcador.addArchivo(arch);
                        }
                    } catch (NumberFormatException nfe) {

                    }
                }
            }
            return marcador;
        } else {
            return null;
        }

    }
}
