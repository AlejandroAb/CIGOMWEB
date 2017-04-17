/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.PCRObj;
import database.Transacciones;
import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class PcrDAO {

    private Transacciones transacciones;

    public PcrDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    public PCRObj initPCR(int idPCR) {
        PCRObj pcr = new PCRObj(idPCR);
        ArrayList<ArrayList<String>> pcrData = transacciones.getPCR("" + idPCR);
        if (pcrData != null && pcrData.size() > 0) {
            ArrayList<String> data = pcrData.get(0);
            pcr.setFw_primer(data.get(0));
            pcr.setRv_primer(data.get(1));
            pcr.setClean_up_kit(data.get(2));
            pcr.setClean_up_method(data.get(3));
            pcr.setComentarios(data.get(4));
            String condiciones = data.get(5);
            //initial denaturation:98_3; annealing:50_1.5; elongation: 72_1; final elongation:72_10;25
            try {
                String etapas[] = condiciones.split(";");
                for (String etapa : etapas) {
                    String detalles[] = etapa.split("[:_]");
                    if (detalles.length >= 3) {
                        /**
                         * Aca se podría hacer una validación de los términos en
                         * la tripleta esperada. Por default se espera que venga
                         * anotada como en el ejemplo de arriba, por lo que
                         * esperamos: etapa, temperaturra y tiempo/ciclos
                         */
                        pcr.addCondition(detalles);
                    }
                }
            } catch (Exception e) {

            }
            return pcr;
        }else{
            return null;
        }
    }
}
