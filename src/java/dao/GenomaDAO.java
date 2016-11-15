/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.Genoma;
import bobjects.NCBINode;
import java.util.ArrayList;
import database.Transacciones;

/**
 *
 * @author Alejandro
 */
public class GenomaDAO {

    private Transacciones transacciones;

    public GenomaDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    public Genoma initGenoma(int idGenoma) {
        //implementar que traiga toda la info del genoma para su pagina
        return null;
    }

    /**
     * Este método trae la información de los genomas a ser desplegada en la
     * página de Blast
     *
     * @param where
     * @return
     */
    public ArrayList<ArrayList<String>> getGenomasBlast(String where) {
        ArrayList<ArrayList<String>> genomas = transacciones.getGenomasBlast(where);
        if(genomas!= null && !genomas.isEmpty()){
            return genomas;
        }else{
            return null;
        }
    }

    public ArrayList<Genoma> getGenomas(String filtro) {
        ArrayList<ArrayList<String>> genos = transacciones.getGenomas(filtro);
        ArrayList<Genoma> genomas = new ArrayList<>();
        if (genos != null && !genos.isEmpty()) {
            for (ArrayList<String> genoma : genos) {
                Genoma g = new Genoma();
                g.setIdgenoma(Integer.parseInt(genoma.get(0)));
                g.setIdmuestra(Integer.parseInt(genoma.get(1)));
                g.setIdtipo_secuenciacion(Integer.parseInt(genoma.get(2)));
                g.setIdSecuenciador(Integer.parseInt(genoma.get(3)));
                g.setTax(new NCBINode(genoma.get(4)));
                g.setName(genoma.get(5));
                g.setDesc(genoma.get(6));
                g.setStrain(genoma.get(7));
                g.setCrecimiento(genoma.get(8));
                //a seguir implementando
            }
            return genomas;
        } else {
            return null;
        }
    }

}
