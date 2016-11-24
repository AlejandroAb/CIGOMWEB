/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import database.Transacciones;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Alejandro
 */
public class SequenceFileCreator {

    private Transacciones transacciones;

    public SequenceFileCreator(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    /**
     * Este método se encarga de crear una rchivo fasta, el cual será mandado al
     * usuario
     *
     * @param fileName nombre del archivo
     * @param ids lista de ids de genes separado por coma
     * @param seqType tipo de secuencia que pidio el usuario NC
     * @param seqHeader string con información para crear el header del fasta
     * @return
     */
    public boolean generateFileFromIDs(String dirPath, String fileName, String ids, String seqType, String seqHeader) {
        String idList[] = ids.split(",");
        StringBuilder sqlIds = new StringBuilder();
        for (String id : idList) {
            if (sqlIds.length() == 0) {
                sqlIds.append("'").append(id.trim()).append("'");
            } else {
                sqlIds.append(",'").append(id.trim()).append("'");
            }
        }
        //el usuario quiere detalles de la proteina predicha
        ArrayList<ArrayList<String>> seqs;
        if (seqHeader.contains("prot")) {
            seqs = transacciones.getSequenceWithProtInfo(sqlIds.toString(), seqType);
        } else {
            seqs = transacciones.getSequenceWithoutProtInfo(sqlIds.toString(), seqType);
        }
        if (seqs == null || seqs.isEmpty()) {
            return false;
        }
        try {
            File f = new File(dirPath);
            if (!f.exists()) {
                f.mkdir();
                f.setWritable(true, false);
            }
            FileWriter fastaFile = new FileWriter(fileName);
            for (ArrayList<String> seq : seqs) {
                StringBuilder secuencia = new StringBuilder(">gnl|");
                if (seq.get(1).equals("GEN")) {//gen_src
                    secuencia.append("GENODB|");
                } else {
                    secuencia.append("METADB|");
                }
                secuencia.append(seq.get(0));//gen_id
                secuencia.append(":").append(seqType).append("_").append(seq.get(3));//seq_type_starnd(+/-)
                if (seqHeader.contains("prot")) {
                    if (!seq.get(6).equals("NULL")) { //uniprot ID
                        secuencia.append(" ").append(seq.get(6));
                    }
                    if (!seq.get(7).equals("NULL")) { //uniprot ID
                        secuencia.append(" ").append(seq.get(7));
                    }
                    if (!seq.get(8).equals("NULL")) { //uniprot ID
                        secuencia.append(" ").append(seq.get(8));
                    }
                }
                secuencia.append("\n").append(seq.get(2)).append("\n");//secuencia
                fastaFile.write(secuencia.toString());
            }
            fastaFile.close();
            return true;
        } catch (IOException ex) {
            Logger.getLogger(SequenceFileCreator.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
