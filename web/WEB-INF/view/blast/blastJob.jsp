<%-- 
    Document   : showJob
    Created on : 15/11/2016, 11:47:23 AM
    Author     : Alejandro
--%>

<%@page import="bobjects.Usuario"%>
<%@page import="job.Job"%>
<%@page import="job.BlastResult"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    if (session == null) {
        response.sendRedirect("index.jsp");
    }
    Usuario usuario = (Usuario) sesion.getAttribute("userObj");
    //String usuario = (String) sesion.getAttribute("usuario");
    // String nombres = (String) sesion.getAttribute("nombres");
    // String apellidos = (String) sesion.getAttribute("apellidos");

    String nombreCompleto = usuario.getNombres() + " " + usuario.getApellidos();


%>
<html>
    <head>
        <!-- Bootstrap Core CSS -->
        <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
        <!-- Timeline CSS -->
        <link href="dist/css/timeline.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="dist/css/sb-admin-2.css" rel="stylesheet">
        <!-- Morris Charts CSS -->
        <link href="bower_components/morrisjs/morris.css" rel="stylesheet">
        <!-- Custom Fonts -->
        <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- DataTables CSS -->
        <link href="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">
        <!-- DataTables Responsive CSS -->
        <link href="bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        

        <title>BLAST</title>

    </head>
    <body >
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; padding-top:10px; padding-left:0px; padding-right:15px; background-color:#ffffff;">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <span class="b1"><img id="logos" src="images/menu/logoC.png" alt="logo" width="23%" height="95px" style="padding-left:60px;" /></span>
                </div>
                <!-- /.navbar-header -->

                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown" style="color: #337ab7">

                        <br>

                        <i class="fa fa-user fa-fw" ></i>            
                        <%                            out.print(nombreCompleto);
                        %>


                    </li>
                    <!-- /.dropdown -->
                </ul>
                <!-- /.navbar-top-links -->

                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">
                            <li class="sidebar-search">
                                <div class="input-group custom-search-form">
                                    <input type="text" class="form-control" placeholder="Buscar...">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                                <!-- /input-group -->
                            </li>
                            <li>
                                <a href="homeCamp"><i class="fa fa-edit fa-fw"></i> HOME</a>
                            </li>

                            <li>
                                <a href="Blast" ><i class="fa fa-edit fa-fw"></i> BLAST</a>
                            </li>
                            <li>
                                <a href="forms.html"><i class="fa fa-edit fa-fw"></i> AMPLICONES</a>
                            </li>
                            <li>
                                <a href="forms.html"><i class="fa fa-edit fa-fw"></i> METAGENOMA</a>
                            </li>
                            <li>
                                <a href="forms.html"><i class="fa fa-edit fa-fw"></i> SITIOS</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-edit fa-fw"></i> ANALISIS</a>
                            </li>
                            <li>
                                <a href="CerrarSesion"><i class="fa fa-edit fa-fw"></i> SALIR</a>
                            </li>

                        </ul>


                    </div>
                    <!-- /.sidebar-collapse -->
                </div>
                <!-- /.navbar-static-side -->
            </nav>

            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <!-- <h1 class="page-header">LOGOS</h1>-->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <br>

                <!-- /.row -->
                <div class="row">

                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                PROCESO BLAST 
                            </div>
                            <div class="panel-body" style="background-color:#dae1e6;">
                                <div class="row">
                                    <form rol="form">


                                        <div class="col-lg-8">
                                            <div class="panel panel-default">
                                                <%
                                                    Object jobObj = request.getAttribute("job");
                                                    Job job = jobObj != null ? (Job) jobObj : null;
                                                    if (job != null) {

                                                %>
                                                <div class="panel-heading" >
                                                    <b>Nombre:</b> <%= job.getJob_name()%>
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <table class="table">

                                                            <tbody style="font-size:15px;">
                                                                <tr class="info">
                                                                    <td><label>Tipo de búsqueda:</label></td>
                                                                    <td><%= job.getJob_type()%></td></td>
                                                                    <td><label>e.val (1x10<sup>-</sup>):</label></td>
                                                                    <td><%= job.getEvalue()%></td>

                                                                </tr>
                                                                <tr class="warning">
                                                                    <td><label>Inicio:</label></td>
                                                                    <td><%= job.getStart_date()%></td>
                                                                    <td><label>Fin:</label></td>
                                                                    <td><%= job.getStart_date()%></td>                                          

                                                                </tr>
                                                                <tr class="info">
                                                                    <td><label>Estatus:</label></td>
                                                                    <td><%= job.getStatus()%></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            <script type="text/javascript">

                                                                var mensaje = <%= job.getMessage()%>;
                                                                //var mensaje = null;
                                                                if (mensaje != null)
                                                                {
                                                                    $(document).ready(function () {
                                                                        $("#mensaje").css("display", "block");
                                                                    });
                                                                }
                                                            </script>
                                                            <tr style="background-color: yellow; display:none;" id="mensaje">
                                                                <td><label>Mensaje:</label></td>
                                                                <td colspan="2"><%= job.getMessage()%></td>

                                                            </tr>                                       
                                                            <tr class="warning">
                                                                <td><label>Metagenomas:</label></td>
                                                                <td><%= job.getMetagenomas()%></td>
                                                                <td></td>
                                                                <td></td>                                           
                                                            </tr>
                                                            <tr class="info">
                                                                <td><label>Genomas:</label></td>
                                                                <td><%= job.getGenomas()%></td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.panel-body -->
                                                <%
                                                  }
                                                %> 
                                            </div>
                                            <!-- /.panel -->
                                        </div>


                                        <div class="col-lg-12">

                                            <script type="text/javascript">
                                                var estatus = "finalizados";
                                                if (estatus == "corriendo")
                                                {
                                                    document.write("<h2 style='color:red;''>PROCESANDO...</h2>");
                                                } else
                                                {


                                                    $(document).ready(function () {
                                                        //alert("El display es " + $("#tabla").css("display"));
                                                        $("#tabla").css("display", "block");
                                                    });

                                                }

                                            </script> 




                                            <div class="panel panel-default" id="tabla" style="display: none ;" >
                                                <div class="panel-heading" style="text-align:center;">
                                                    <b>GENOMAS</b>
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    <div class="dataTable_wrapper">
                                                        <table width="100%" class="table table-striped table-bordered" id="genomas-blast">
                                                            <thead>
                                                                <tr style="font-size:15px; text-align:left;">
                                                                    <th style="text-align:center;">Marcar todos:<input type="checkbox" name="marcarTodo" id="marcarTodoG" /></th>
                                                                    <th>Query</th>
                                                                    <th>Target</th>
                                                                    <th>Fuente</th>
                                                                    <th style="width:15%">Definición</th>
                                                                    <th>Taxa</th>
                                                                    <th>%ID</th>
                                                                    <th>QF</th>
                                                                    <th>QT</th>
                                                                    <th>SF</th>
                                                                    <th>ST</th>
                                                                    <th>e-val</th>
                                                                    <th>bit-s</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tgenomas">  
                                                                <%
                                                                    Object blastResult = request.getAttribute("table");
                                                                    ArrayList<BlastResult> results = blastResult != null ? (ArrayList<BlastResult>) blastResult : null;

                                                                    if (results != null) {
                                                                        for (BlastResult result : results) {

                                                                %> 
                                                                <tr style="text-align: left; font-size:14px;" class="genomas" id="genoma">
                                                                    <td style="text-align:center;"><input type="checkbox" value="<%= result.getGen_id() %>" id="checkgenoma"></td>
                                                                    <td><%= result.getQuery()%></td>
                                                                    <td><%= result.getGen_id()%></td>
                                                                    <td><%= result.getSource()%></td>
                                                                    <td><%= result.getTarget_definition()%></td>
                                                                    <td><%= result.getTaxa()%></td>
                                                                    <td><%= result.getIdentity()%></td>
                                                                    <td><%= result.getQuery_from()%></td>
                                                                    <td><%= result.getQuery_to()%></td>
                                                                    <td><%= result.getTarget_from()%></td>
                                                                    <td><%= result.getTarget_to()%></td>
                                                                    <td><%= result.getEval()%></td>
                                                                    <td><%= result.getBit_score()%></td>
                                                                </tr>   
                                                                <%
                                                               }
                                                           }
                                                                %>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.panel-body -->
                                            </div>
                                            <!-- /.panel -->
                                        </div>


                                        <!-- /.col-lg-6 (nested) -->

                                        <!-- /.col-lg-4 (nested) -->
                                </div>
                                <!-- /.row (nested) -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                    </div>

                </div>

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>

        <!-- Morris Charts JavaScript -->
        <script src="bower_components/raphael/raphael-min.js"></script>
        <script src="bower_components/morrisjs/morris.min.js"></script>
        <script src="js/morris-data.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>

        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>

        <!-- Page-Level Demo Scripts - Tables - Use for reference -->
        <script>
                                                $(document).ready(function () {
                                                    $('#genomas-blast').DataTable({
                                                        responsive: true
                                                    });
                                                });
        </script>
        
                        <!--SCRIPT PARA MARCAR Y DESMARCAR LOS CHECKS DE LA TABLA GENOMAS-->
        <script>
            $("#marcarTodoG").change(function() {
                if ($(this).is(':checked')) {
                    //$("input[type=checkbox]").prop('checked', true); //todos los check del documento
                    $("#genomas-blast input[type=checkbox]").prop('checked', true); //solo los del objeto #tabla-genomasblast
                } else {
                    //$("input[type=checkbox]").prop('checked', false);//todos los check del documento
                    $("#genomas-blast input[type=checkbox]").prop('checked', false);//solo los del objeto #tablas-genomasblast
                }
            });
        </script> 

    </body>
</html>