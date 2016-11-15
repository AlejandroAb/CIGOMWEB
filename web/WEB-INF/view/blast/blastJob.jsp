<%-- 
    Document   : showJob
    Created on : 15/11/2016, 11:47:23 AM
    Author     : Alejandro
--%>

<%@page import="job.Job"%>
<%@page import="job.BlastResult"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Blast Result</title>
    </head>
    <body>
        <h2>  <%

            Object jobObj = request.getAttribute("job");
            Job job = jobObj != null ? (Job) jobObj : null;
            if (job != null) {
                out.println("<br>JOB: " + job.getId_job() + " - " + job.getJob_name());
                out.println("<br>Estatus: " + job.getStatus());
                out.println("<br>Mensaje: " + job.getMessage());
            }
            Object blastResult = request.getAttribute("table");
            ArrayList<BlastResult> results = blastResult != null ? (ArrayList<BlastResult>) blastResult : null;

            if (results != null) {
                for (BlastResult result : results) {
                    out.println("<br>" + result.getQuery() + "&nbsp;&nbsp;&nbsp;" + result.getTarget() + "&nbsp;&nbsp;&nbsp;" + result.getGen_id() + "&nbsp;&nbsp;&nbsp;" + result.getSource() + "&nbsp;&nbsp;&nbsp;" + result.getTarget_definition()+ "&nbsp;&nbsp;&nbsp;" +result.getTaxa() + "&nbsp;&nbsp;&nbsp;" +result.getEval()+ "&nbsp;&nbsp;&nbsp;" +result.getBit_score()+ "&nbsp;&nbsp;&nbsp;" +result.getIdentity());
                }
            }
            %></h2>
    </body>
</html>
