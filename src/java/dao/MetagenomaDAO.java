/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

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
}
