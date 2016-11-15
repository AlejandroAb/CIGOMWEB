/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import database.Transacciones;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Part;
import job.BlastResult;
import job.Job;
import utils.RandomString;

/**
 *
 * @author Alejandro
 */
public class JobDAO {

    private Transacciones transacciones;
    private String metagenoma_dbs;
    private String genoma_dbs;
     private String metagenoma_dbs_q;//quoted
    private String genoma_dbs_q;//quoted

    public JobDAO(Transacciones transacciones) {
        this.transacciones = transacciones;
    }

    public String getMetagenoma_dbs() {
        if (metagenoma_dbs != null) {
            return metagenoma_dbs;
        } else {
            return "";
        }
    }
     public String getMetagenoma_dbsQuoted() {
        if (metagenoma_dbs != null) {
           return metagenoma_dbs;
        } else {
            return "";
        }
    }

    public void setMetagenoma_dbs(String metagenoma_dbs) {
        this.metagenoma_dbs = metagenoma_dbs;
    }

    public String getGenoma_dbs() {
        if (genoma_dbs != null) {
            return genoma_dbs;
        } else {
            return "";
        }
    }

    public void setGenoma_dbs(String genoma_dbs) {
        this.genoma_dbs = genoma_dbs;
    }

    /**
     * Se encarga de crear un archivo fasta a partir del archivo del usuario
     *
     * @param idUsuario el usuario que solicitó el job
     * @param job_name el nombre que le dió al job
     * @param seqFilePath path al archivo, luego se crea un directorio con el id
     * del job
     * @param eval evalue
     * @param seqFileName el nombre del archivo.
     * @param jobType el tipo de job bastp, blastn, blastx, etc
     * @param host host del usuario que solicita el job
     * @param idmetagenomas lista de ids de metagenomas contra los que se corre
     * el blast: 1,4,5
     * @param idgenomas lista de ids de metagenomas contra los que se corre el
     * blast: 1,4,5
     * @param blasdb_dir directorio donde se encuentran las bases de datos de
     * blast
     * @param filePart archivo
     * @param withIntergenic if true en buscadas de BLAST N se pueden blastear
     * las intergénicas
     * @return el id del job - url del job
     * @throws IOException
     */
    public String saveFastaFile(int idUsuario, String job_name, String jobType, double eval, String seqFilePath, String seqFileName, String host, Part filePart, String idmetagenomas, String idgenomas, String blasdb_dir, boolean withIntergenic) throws IOException {
        RandomString rs = new RandomString(12);
        String job_url = rs.nextString();
        int idJob = transacciones.createJob(idUsuario, job_name, job_url, jobType, eval, seqFilePath, host, "created", "");
        boolean hayDBs = false;
        if (idmetagenomas != null && idmetagenomas.trim().length() > 0) {
            String idsm[] = idmetagenomas.split(",");
            metagenoma_dbs = "";
            metagenoma_dbs_q = "";
            for (String id : idsm) {
                id = id.trim();
                transacciones.insertJobIDMetagenoma(idJob, id);
                if (jobType.equals("BLASTN")) {
                    metagenoma_dbs += blasdb_dir + "metagenoma_nc_" + id + ".fasta ";
                    metagenoma_dbs_q+= "\'"+blasdb_dir + "metagenoma_nc_" + id + ".fasta\'";
                    if (withIntergenic) {
                        metagenoma_dbs += blasdb_dir + "metagenoma_5p_" + id + ".fasta ";
                        metagenoma_dbs += blasdb_dir + "metagenoma_3p_" + id + ".fasta ";
                        metagenoma_dbs_q+= "\'"+blasdb_dir + "metagenoma_5p_" + id + ".fasta\'";
                        metagenoma_dbs_q+= "\'"+blasdb_dir + "metagenoma_3p_" + id + ".fasta\'";
                    }
                } else {
                    metagenoma_dbs += blasdb_dir + "metagenoma_aa_" + id + ".fasta ";
                    metagenoma_dbs_q+= "\'"+blasdb_dir + "metagenoma_aa_" + id + ".fasta\'";
                }

                hayDBs = true;
            }
        }
        if (idgenomas != null && idgenomas.trim().length() > 0) {
            String ids[] = idgenomas.split(",");
            genoma_dbs = "";
            genoma_dbs_q = "";
            for (String id : ids) {
                id = id.trim();
                transacciones.insertJobIDMetagenoma(idJob, id);
                if (jobType.equals("BLASTN")) {
                    genoma_dbs += blasdb_dir + "genoma_nc_" + id + ".fasta ";
                    genoma_dbs_q+= "\'"+blasdb_dir + "genoma_nc_" + id + ".fasta\'";
                    if (withIntergenic) {
                        genoma_dbs += blasdb_dir + "genoma_5p_" + id + ".fasta ";
                        genoma_dbs += blasdb_dir + "genoma_3p_" + id + ".fasta ";
                        genoma_dbs_q+= "\'"+blasdb_dir + "genoma_5p_" + id + ".fasta\'";
                        genoma_dbs_q+= "\'"+blasdb_dir + "genoma_3p_" + id + ".fasta\'";
                    }
                } else {
                    genoma_dbs += blasdb_dir + "genoma_aa_" + id + ".fasta ";
                    genoma_dbs_q+= "\'"+blasdb_dir + "genoma_aa_" + id + ".fasta\'";
                }

                hayDBs = true;
            }
        }
        if (idJob != -1 && hayDBs) {
            OutputStream out = null;
            InputStream filecontent = null;
            try {
                File directorio = new File(seqFilePath + idJob);
                directorio.mkdir();
                directorio.setReadable(true, false);
                directorio.setWritable(true, false);
                directorio.setExecutable(true, false);
                out = new FileOutputStream(new File(seqFilePath + +idJob + "/"
                        + seqFileName));
                filecontent = filePart.getInputStream();

                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }
                return idJob + "-" + job_url;

            } catch (FileNotFoundException fne) {
                return "Error writing file";

            } catch (IOException ioe) {
                return "Error writing file";

            } finally {
                if (out != null) {
                    out.close();

                }
                if (filecontent != null) {
                    filecontent.close();

                }

            }
        } else {
            return "Error creating job into database";
        }
    }

    public String getMetagenoma_dbs_q() {
        return metagenoma_dbs_q;
    }

    public void setMetagenoma_dbs_q(String metagenoma_dbs_q) {
        this.metagenoma_dbs_q = metagenoma_dbs_q;
    }

    public String getGenoma_dbs_q() {
        return genoma_dbs_q;
    }

    public void setGenoma_dbs_q(String genoma_dbs_q) {
        this.genoma_dbs_q = genoma_dbs_q;
    }

    /**
     * Se encarga de crear un archivo fasta a partir de la secuencia ingresada
     * por el usuario
     *
     * @param idUsuario elusuairo que esta creando el job
     * @param job_name el nombre del job
     * @param seqFilePath path al archivo, luego se crea un directorio con el id
     * del job
     * @param eval el valor de corte minimo
     * @param seqFileName el nombre del archivo.
     * @param jobType el tipo de job bast p, blastn, etc
     * @param host host del usuario que solicita el job
     * @param idmetagenomas
     * @param idgenomas
     * @param seq
     * @param blasdb_dir
     * @param withIntergenic
     * @return id job
     * @throws IOException
     */
    public String writeFastaFile(int idUsuario, String job_name, String jobType, double eval, String seqFilePath, String seqFileName, String host, String seq, String idmetagenomas, String idgenomas, String blasdb_dir, boolean withIntergenic) throws IOException {
        RandomString rs = new RandomString(12);
        String job_url = rs.nextString();
        int idJob = transacciones.createJob(idUsuario, job_name, job_url, jobType, eval, seqFilePath, host, "created", "");
        boolean hayDBs = false;
        if (idmetagenomas != null && idmetagenomas.trim().length() > 0) {
            String idsm[] = idmetagenomas.split(",");
            metagenoma_dbs = "";
            metagenoma_dbs_q = "";
            for (String id : idsm) {
                id = id.trim();
                transacciones.insertJobIDMetagenoma(idJob, id);
                if (jobType.equals("BLASTN")) {
                    metagenoma_dbs += blasdb_dir + "metagenoma_nc_" + id + ".fasta ";
                    metagenoma_dbs_q +="'" + blasdb_dir + "metagenoma_nc_" + id + ".fasta' ";
                    if (withIntergenic) {
                        metagenoma_dbs += blasdb_dir + "metagenoma_5p_" + id + ".fasta ";
                        metagenoma_dbs += blasdb_dir + "metagenoma_3p_" + id + ".fasta ";
                        metagenoma_dbs_q +="'" + blasdb_dir + "metagenoma_5p_" + id + ".fasta' ";
                        metagenoma_dbs_q +="'" + blasdb_dir + "metagenoma_3p_" + id + ".fasta' ";
                    }
                } else {
                    metagenoma_dbs += blasdb_dir + "metagenoma_aa_" + id + ".fasta ";
                    metagenoma_dbs_q +="'" + blasdb_dir + "metagenoma_aa_" + id + ".fasta' ";
                }

                hayDBs = true;
            }
        }
        if (idgenomas != null && idgenomas.trim().length() > 0) {
            String ids[] = idgenomas.split(",");
            genoma_dbs = "";
            genoma_dbs_q = "";
            for (String id : ids) {
                id = id.trim();
                transacciones.insertJobIDGenoma(idJob, id);
                if (jobType.equals("BLASTN")) {
                    genoma_dbs += blasdb_dir + "genoma_nc_" + id + ".fasta ";
                    genoma_dbs_q +="'"+ blasdb_dir + "genoma_nc_" + id + ".fasta' ";
                    if (withIntergenic) {
                        genoma_dbs += blasdb_dir + "genoma_5p_" + id + ".fasta ";
                        genoma_dbs += blasdb_dir + "genoma_3p_" + id + ".fasta ";
                        genoma_dbs_q +="'"+ blasdb_dir + "genoma_5p_" + id + ".fasta' ";
                        genoma_dbs_q +="'"+ blasdb_dir + "genoma_3p_" + id + ".fasta' ";
                        
                    }
                } else {
                    genoma_dbs += blasdb_dir + "genoma_aa_" + id + ".fasta ";
                    genoma_dbs_q +="'"+ blasdb_dir + "genoma_aa_" + id + ".fasta' ";
                }
                hayDBs = true;
            }
        }
        if (idJob != -1 && hayDBs) {
            OutputStream out = null;
            FileWriter writer;
            try {
                File directorio = new File(seqFilePath + idJob);
                directorio.mkdir();
                directorio.setReadable(true, false);
                directorio.setWritable(true, false);
                directorio.setExecutable(true, false);

                writer = new FileWriter(seqFilePath + +idJob + "/" + seqFileName);

                writer.write(seq);
                writer.close();
                return idJob + "-" + job_url;

            } catch (FileNotFoundException fne) {
                return "Error writing file";

            } catch (IOException ioe) {
                return "Error writing file";

            } finally {
                if (out != null) {
                    out.close();

                }

            }
        } else {
            return "Error creating job into database";
        }
    }

    /**
     * Se encarga de actualizar el estatutus un job
     *
     * @param id_job job a actualizar
     * @param status estado/status en el que está
     * @param msg por si hay algún mensaje en caso de error
     * @param withDate si true -> actualiza end_date
     * @return
     */
    public boolean updateJobStatus(String id_job, String status, String msg, boolean withDate) {
        if (msg.length() > 255) {
            msg = msg.substring(0, 255);
        }
        return transacciones.updateJobStatus(id_job, status, msg, withDate);
    }

    /**
     * Este método se encarga de iniciar un JOB basado en el uid que es el ID
     * que tiene el usuario para ir al link.
     *
     * @param userId
     * @return
     */
    public Job initJobObject(String userId) {
        ArrayList<ArrayList> jobDetails = transacciones.getJobDetails(userId);
        if (jobDetails != null && jobDetails.size() > 0) {
            Job job = null;
            int i = 0;
            ArrayList<String> rec = jobDetails.get(0);
            for (String val : rec) {
                if (val != null) {
                    switch (i) {
                        case 0:
                            job = new Job(val);
                            job.setURL(userId);
                        case 1:
                            job.setJob_name(val);
                        case 2:
                            job.setJob_type(val);
                        case 3:
                            job.setEvalue(val);
                        case 4:
                            job.setStart_date(val);
                        case 5:
                            String endDate = val;
                            if (endDate != null) {
                                job.setEnd_date(endDate);
                            } else {
                                job.setEnd_date("-");
                            }
                        case 6:
                            job.setStatus(val);
                        case 7:
                            job.setMessage(val);
                    }
                }
                i++;
            }
            return job;
        } else {
            return null;
        }
    }

    public void compilaQueryGenInfo() {
        transacciones.compilePreparedGene();
    }

    /**
     * Este método se encarga de leer el archivo out.txt.sorted que se genera
     * despues de ejecutar blast. Se espera leer un archivo de cuaro columnas
     * con el id del query \t id del target \t evalue \t bitscore
     *
     * @param fileName el archivo a leer
     * @param lines el número máximo de resultados a leer -1 = todo
     * @return
     */
    public ArrayList<BlastResult> readBlastOutFile(String fileName, int lines) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(fileName));
            String linea;
            ArrayList<BlastResult> res = new ArrayList<>();
            int lineas = 0;
            while ((linea = reader.readLine()) != null) {
                lineas++;
                String[] campos = linea.split("\t");
                BlastResult result = new BlastResult();
                result.setQuery(campos[0]);
                result.setTarget(campos[1]);
                result.setIdentity(campos[2]);
                result.setQuery_from(campos[3]);
                result.setQuery_to(campos[4]);
                result.setTarget_from(campos[5]);
                result.setTarget_to(campos[6]);
                result.setEval(campos[7]);
                result.setBit_score(campos[8]);
                String type = "";
                if (campos[1].contains(":5P")) {
                    type = " i5p";
                } else if (campos[1].contains(":3P")) {
                    type = " i3p";
                }
                if (campos[1].contains("METADB")) {
                    result.setSource("Metagenoma" + type);
                } else if (campos[1].contains("GENODB")) {
                    result.setSource("Genoma" + type);
                }
                //depende la version de blast usa | o :
                int idx_id = campos[1].lastIndexOf("|");
                if (idx_id < 0) {
                    idx_id = campos[1].indexOf(":");
                }
                if (idx_id < 0) {
                    idx_id = 0;
                }
                result.setGen_id(campos[1].substring(idx_id + 1, campos[1].lastIndexOf(":")));
                ArrayList<ArrayList<String>> targetDef;
                if (campos[1].contains("METADB")) {
                    targetDef = transacciones.executePreparedMetaGene(result.getGen_id());
                } else {
                    targetDef = transacciones.executePreparedGene(result.getGen_id());
                }

                if (targetDef != null && targetDef.size() > 0) {
                    ArrayList<String> bestDef = targetDef.get(0);
                    //select sp.uniprot_id, uniprot_acc, prot_name,ncbi_node.name,tipo_muestra,eval
                    String prot = bestDef.get(0) + ":" + bestDef.get(2) + "(" + bestDef.get(5) + ")";
                    if (prot.startsWith(":")) {
                        result.setTarget_definition("No asignado");
                        result.setTaxa("NA");
                        result.setSource(result.getSource() + " - " + bestDef.get(4));
                    } else {
                        result.setTarget_definition(prot);
                        result.setTaxa(bestDef.get(3));
                        result.setSource(result.getSource() + " - " + bestDef.get(4));
                    }
                } else {
                    result.setTarget_definition("No asignado");
                    result.setTaxa("NA");
                    result.setSource(result.getSource() + " - ND");
                }
                res.add(result);

                if (lineas != -1 && lineas > lines) {
                    break;
                }
            }
            return res;

        } catch (FileNotFoundException ex) {
            Logger.getLogger(JobDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } catch (IOException ex) {
            Logger.getLogger(JobDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void closeConexion() {
        this.transacciones.desconecta();
    }
}
