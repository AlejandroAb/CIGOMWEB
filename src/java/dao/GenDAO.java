/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bobjects.GenObj;
import bobjects.GenSeqObj;
import bobjects.SecuenciaObj;
import database.Transacciones;
import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */

public class GenDAO {

    private Transacciones transacciones;
    private boolean debug = false;

    public String almacenaGen(GenObj gen) {
        String log = "";
        String query = "INSERT INTO Gen (gen_id,object_id,gen_map_id,gen_type,"
                + "gen_strand,gen_function,contig_id,contig_gen_id,contig_from,contig_to) "
                + "VALUES ("
                + "'" + gen.getGenID() + "','', '" + gen.getGene_map_id()
                + "', '" + gen.getGenType() + "', '" + gen.getGen_strand()
                + "', '" + gen.getGen_function() + "', '" + gen.getContig_id()
                + "', '" + gen.getContig_gen_id() + "', '" + gen.getContig_from() + "', '" + gen.getContig_to() + "')";
        if (!transacciones.insertaQuery(query)) {
            log += "Error insertando gen: " + gen.getGenID() + " - " + query + "\n";
        }
        for (GenSeqObj seq : gen.getSequences()) {
            String querySeq = "INSERT INTO Gen_Seq (gen_id, seq_type, seq_from, seq_to, seq_size, sequence) VALUES ("
                    + "'" + gen.getGenID() + "', '" + seq.getSeqType()
                    + "', '" + seq.getSeq_from() + "', '" + seq.getSeq_to() + "', " + seq.getSeq_size()
                    + ", '" + seq.getSequence() + "')";
            if (!transacciones.insertaQuery(querySeq)) {
                log += "Error insertando secuencia: " + gen.getGenID() + " - " + querySeq + "\n";
            }
        }

        return log;
    }
    
    public GenObj initGen(String idGen) {
       String isGenoma = transacciones.getIsGenoma(idGen);
       //System.out.println("isgenoma="+isGenoma);
        GenObj gen = new GenObj(idGen);
       if(isGenoma.equals("TRUE")){
           ArrayList<ArrayList> genAL = transacciones.getGenGenoma(idGen);
           if (genAL != null && genAL.size() > 0) {
           
           ArrayList<String> ge = genAL.get(0);
           
           gen.setGenID(ge.get(0));
           gen.setGenType(ge.get(1));
           gen.setContig_id(ge.get(2));
           gen.setContig_gen_id(ge.get(3));
           gen.setGen_strand(ge.get(4));
           gen.setGen_src(ge.get(5));
           gen.setName(ge.get(7));
           gen.setIdmuestra(Integer.parseInt(ge.get(11)));
           gen.setEtiquetaMuestra(ge.get(12));
           gen.setProfundidad(ge.get(13));
           gen.setTipoMuestra(ge.get(14));
           gen.setGen_lenght(Integer.parseInt(ge.get(8)));
           gen.setContig_from(Integer.parseInt(ge.get(9)));
           gen.setContig_to(Integer.parseInt(ge.get(10)));
           
           }
       }else {
           
           ArrayList<ArrayList> genAL = transacciones.getGenMetagenoma(idGen);
           if (genAL != null && genAL.size() > 0) {
           
           ArrayList<String> ge = genAL.get(0);
           
           gen.setGenID(ge.get(0));
           gen.setGenType(ge.get(1));
           gen.setContig_id(ge.get(2));
           gen.setContig_gen_id(ge.get(3));
           gen.setGen_strand(ge.get(4));
           gen.setGen_src(ge.get(5));
           gen.setName(ge.get(7));
           gen.setIdmuestra(Integer.parseInt(ge.get(11)));
           gen.setEtiquetaMuestra(ge.get(12));
           gen.setProfundidad(ge.get(13));
           gen.setTipoMuestra(ge.get(14));
           gen.setGen_lenght(Integer.parseInt(ge.get(8)));
           gen.setContig_from(Integer.parseInt(ge.get(9)));
           gen.setContig_to(Integer.parseInt(ge.get(10)));
           
           }
           
       }
     
       ArrayList<ArrayList> secuenciasAL = transacciones.getGenSecuencias(idGen);
       //if test for null
       if (secuenciasAL != null && secuenciasAL.size() > 0) {
       for(ArrayList<String> secuencia: secuenciasAL){
           if(secuencia.get(0).equals("AA")){
               gen.getSecAA().setSecuencia(secuencia.get(1));
           }else if(secuencia.get(0).equals("5P")){
               gen.getSec5P().setSecuencia(secuencia.get(1));
           }else if(secuencia.get(0).equals("3P")){
               gen.getSec3P().setSecuencia(secuencia.get(1));
           }else if(secuencia.get(0).equals("NC")){
               gen.getSecNC().setSecuencia(secuencia.get(1));
           }
       }
       }

        return gen; 
    }

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    public GenDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

}
