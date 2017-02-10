/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import database.Transacciones;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author Alejandro
 */
public class TaxaDAO {

    private Transacciones transacciones;
    private long conteos = 0;

    public TaxaDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    public Transacciones getTransacciones() {
        return transacciones;
    }

    public void setTransacciones(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    public long getConteos() {
        return conteos;
    }

    public void setConteos(long conteos) {
        this.conteos = conteos;
    }

    /**
     * Este método se encarga de hacer la búsqueda de taxones de acuerdo a un
     * rango y su nombre.
     *
     * @param rank el rango del taxón: class,
     * @param name
     * @return regresa un ArrayList<ArrayList<String>> la cual contien e toda la
     * información para generar la tabla. Cada sublista es un registro y
     * contiene los siguientes datos en el mismo orden que se
     * presenta:idmarcador, mar_name,idmuestra, etiqueta, tipoMuestra,
     * tipoProfundidad, profundidad, numero de secs
     */
    public ArrayList<ArrayList<String>> getConteosByTaxName(String rank, String name) {
        List<String> rangos = Arrays.asList("kingdom", "superkingdom", "subkingdom", "superphylum", "phylum", "subphylum", "superclass", "infraclass", "class", "subclass", "parvorder", "superorder", "infraorder", "order", "suborder", "superfamily", "family", "subfamily", "tribe", "subtribe", "genus", "subgenus", "species", "species group", "species subgroup", "subspecies", "forma", "varietas", "no rank");
        if (!rangos.contains(rank)) {
            return null;
        } else {
            if (rank.equals("superkingdom")) {
                rank = "kingdom";
            } else if (rank.equals("order")) {
                rank = "orden";
            } else if (rank.equals("species group")) {
                rank = "species_group";
            } else if (rank.equals("species subgroup")) {
                rank = "species_subgroup";
            } else if (rank.equals("no rank")) {
                rank = "no_rank";
            }
        }
        ArrayList<ArrayList<String>> tabla = new ArrayList();
        ArrayList<ArrayList> marcadoresCounts = transacciones.getConteosMarcadorPorTaxon(rank, name);
        conteos = 0;
        for (ArrayList<String> marcador : marcadoresCounts) {
            ArrayList<String> registro = new ArrayList();
            String idMarcador = marcador.get(0);
            String counts = marcador.get(1);
            conteos += Integer.parseInt(counts);
            registro.add(idMarcador);
            ArrayList<ArrayList> detalles = transacciones.getDetallesMuestraMarcador(idMarcador);
            if (detalles.size() > 0) {
                ArrayList<String> detalle = detalles.get(0);
                registro.add(detalle.get(0));//nombre marcador
                registro.add(detalle.get(1));//idMuestra
                registro.add(detalle.get(2));//etiqueta
                registro.add(detalle.get(3));//tipo_muestra
                registro.add(detalle.get(4));//tipo_prof
                registro.add(detalle.get(5));//profundidad
            } else {
                registro.add("");
                registro.add("");
                registro.add("");
                registro.add("");
                registro.add("");
                registro.add("");
            }
            registro.add(counts);
            tabla.add(registro);
        }
        return tabla;
    }
}
