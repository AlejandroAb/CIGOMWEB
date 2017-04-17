/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bobjects;

import java.util.ArrayList;

/**
 *
 * @author Alejandro
 */
public class PCRObj {
    int idPCR;
    String fw_primer="";
    String rv_primer="";
    String clean_up_kit="";
    String clean_up_method="";
    String comentarios = "";
    ArrayList<String[]> pcr_cond = new ArrayList<>();

    public PCRObj(int idPCR) {
        this.idPCR = idPCR;
    }

    public int getIdPCR() {
        return idPCR;
    }

    public void setIdPCR(int idPCR) {
        this.idPCR = idPCR;
    }

    public String getFw_primer() {
        return fw_primer;
    }

    public void setFw_primer(String fw_primer) {
        this.fw_primer = fw_primer;
    }

    public String getRv_primer() {
        return rv_primer;
    }

    public void setRv_primer(String rv_primer) {
        this.rv_primer = rv_primer;
    }

    public String getClean_up_kit() {
        return clean_up_kit;
    }

    public void setClean_up_kit(String clean_up_kit) {
        this.clean_up_kit = clean_up_kit;
    }

    public String getClean_up_method() {
        return clean_up_method;
    }

    public void setClean_up_method(String clean_up_method) {
        this.clean_up_method = clean_up_method;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public ArrayList<String[]> getPcr_cond() {
        return pcr_cond;
    }

    public void setPcr_cond(ArrayList<String[]> pcr_cond) {
        this.pcr_cond = pcr_cond;
    }
    public void addCondition(String[] condition){
        this.pcr_cond.add(condition);
    }
    
}
