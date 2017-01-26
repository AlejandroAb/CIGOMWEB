/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.Muestra;
import database.Transacciones;
import java.util.ArrayList;
/**
 *
 * @author Jose Pefi
 */
public class MuestraDAO {
    
    private Transacciones transacciones;

    public MuestraDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }
    
    /**
     * Este método se encarga de iniciar un JOB basado en el uid que es el ID
     * que tiene el usuario para ir al link.
     *
     * @param userId
     * @return
     */
    public Muestra initMuestraObject(int idMuestra) {
        ArrayList<ArrayList> muestraDetails = transacciones.getMuestra(idMuestra);
       
       if (muestraDetails != null && muestraDetails.size() > 0) {
            Muestra muestra = null;
            int i = 0;
            ArrayList<String> rec = muestraDetails.get(0);
            for (String val : rec) {
                if (val != null) {
                    switch (i) {
                        case 0:
                            muestra = new Muestra(Integer.parseInt(val));
                        case 1:
                            muestra.setProcess(val);
                        case 2:
                            muestra.setContenedor(val);
                        case 3:
                            muestra.setSamp_size(val);
                        case 4:
                            muestra.setprotocolo(val);
                        case 5:
                            muestra.setNotas(val);
                        case 6:
                            muestra.setreal_to_oxy(val);
                        case 7:
                            muestra.setcontenedor_temp(val);
                    }
                }
                i++;
            }
            return muestra;
        }
        else{
        return null;
        }
    }
    
}
