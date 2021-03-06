<%-- 
    Document   : blast
    Created on : 24/10/2016, 01:47:02 PM
    Author     : Jose Pefi
--%>

<%@page import="job.BlastResult"%>
<%@page import="job.Job"%>
<%@page import="bobjects.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.Transacciones"%>
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
    String nombreCompleto = usuario.getNombres() + " " + usuario.getApellidos();
%>
<!DOCTYPE html>
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
        <!-- Custom Fonts -->
        <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


        <!-- DataTables CSS -->
        <link href="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">
        <!-- DataTables Responsive CSS -->
        <link href="bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">     

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>


        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>

        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>

        <!---TOlTIPS---->
        <link href="themes/1/tooltip.css" rel="stylesheet" type="text/css" >
        <script src="themes/1/tooltip.js" type="text/javascript"></script> 
        
        <!--ALERTAS-->
        <script src="alerta/dist/sweetalert-dev.js"></script>
        <link rel="stylesheet" href="alerta/dist/sweetalert.css">

        <!-- Forma para pedir secuencias -->
        <script src="js/seqRequest.js"></script>

        <!--ESCRIPT PARA OBTENER LOS VALORES DE LA TABLA GENOMAS-->
        <script type="text/javascript">

            

        </script> 

        <script>
            $(document).ready(function () {
                //$('#loading').hide();
                $('form').submit(function () {
                     swal({
                     title: "",
                     imageUrl: "images/loading.gif",
                     showConfirmButton: false
                     });
                });
            });
        </script>

        <script>
            $(document).ready(function () {
                $('#genomas-blast').DataTable({
                    responsive: true,
                    pageLength: 25,
                    order: [[ 11, "asc" ],[ 12, "desc" ]]
                });
            });
        </script>    

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BLAST</title>
    </head>
    <body>
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; padding-top:10px; padding-right:15px; background-color:#ffffff;">
                <div class="col-lg-9">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                        <span class="b1"><img id="logos" src="images/logotipo4.png" alt="logo" width="85%" height="100px" style="padding-left:10px;" /></span>
                        <!--<img id="logos" src="images/logosistema2.png" alt="logo" width="40%" height="60px"  />-->
                    </div>
                </div>
                <!-- /.navbar-header -->

                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown" style="color: #337ab7">

                        <br>

                        <i class="fa fa-user fa-fw" ></i>            
                        <%                        out.print(nombreCompleto);
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
                                <a href="blast" ><i class="fa fa-edit fa-fw"></i> BLAST</a>
                            </li>
                            <!--<li>
                                <a href="#"><i class="fa fa-edit fa-fw"></i> AMPLICONES</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-edit fa-fw"></i> METAGENOMA</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-edit fa-fw"></i> SITIOS</a>
                            </li>
                            <li>
                                <a href="analisis.jsp"><i class="fa fa-edit fa-fw"></i> ANALISIS</a>
                            </li>-->
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
                        <h1 class="page-header">BLAST-JOB</h1> 
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <br>
                <!-- /.row -->
                <div class="row">

                    <div class="col-lg-12">
                        <div class="panel panel-default" >
                            <div class="panel-heading" style="background-color:#dae1e6;">
                                Resultados <button class="fa fa-chevron-up" id="principal-job"></button>
                            </div>
                            <div class="panel-body" style="background-color:#eee;" id="caebecera-blastjob">

                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <!-- /.panel-heading -->
                                        <div class="panel-body" >
                                            <div class="dataTable_wrapper">
                                                <table width="100%" class="table table-striped table-bordered table-hover" id="tabla-misbusquedas">

                                                    <%
                                                        Object jobObj = request.getAttribute("job");
                                                        Job job = jobObj != null ? (Job) jobObj : null;
                                                        if (job != null) {

                                                    %>
                                                     <script>

                                                        var mensaje = "<%= job.getMessage() %>";
                                                        
                                                        if (mensaje !== "" && mensaje !== null)
                                                        {
                                                            $(document).ready(function () {
                                                                $("#mensaje").css("display", " table-row");
                                                            });
                                                        }
                                                    </script> 
                                                    <tr style="display:none;">
                                                        <th><input type="text" value="<%= job.getJob_url() %>" id="urljob" name="urljob" /></th>
                                                    </tr>                                                    
                                                    <tr>
                                                        <th style="width:10%; font-size:15px;">Nombre:</th>
                                                        <td colspan="4"><code><%= job.getJob_name()%></code></td>
                                                    </tr>
                                                    <tr>
                                                        <th style="font-size:15px;">Tipo de búsqueda:</th>
                                                        <td style="width:20%;"><code><%= job.getJob_type()%></code></td>
                                                        <th style="font-size:15px; width:10%;" colspan="2">e.val (1x10<sup>-</sup>):</th>
                                                        <td >
                                                            <code><%= job.getEvalue()%></code>
                                                        </td>                                            
                                                    </tr>
                                                    <tr>                                          
                                                        <th style="font-size:15px;">Inicio:</th>
                                                        <td ><code><%= job.getStart_date()%></code></td>
                                                        <th style="font-size:15px; width:10%;" colspan="2">Fin:</th>
                                                        <td ><code><%= job.getStart_date()%></code></td>                                           
                                                    </tr>
                                                    <tr>
                                                        <th style="font-size:15px;">Estatus:</th>
                                                        <td colspan="4"><code><%= job.getStatus()%></code></td>
                                                    </tr>
                                                    <tr style="background-color: yellow; display:none;" id="mensaje">
                                                        <th style="font-size:15px;">Mensaje:</th>
                                                        <td colspan="4"><code><%= job.getMessage()%></code></td>
                                                    </tr>                                                    
                                                    <tr>
                                                        <th style="font-size:15px;">Metagenomas:</th>
                                                        <td colspan="4"><code><%= job.getMetagenomas()%></code></td>
                                                    </tr>
                                                    <tr>
                                                        <th style="font-size:15px;">Genomas:</th>
                                                        <td colspan="4"><code><%= job.getGenomas()%></code></td>
                                                    </tr>
                                                    <tr>
                                                        <th style="font-size:15px;">Query:</th>
                                                        <td colspan="4"><code><a href="serveFile?file=<%= job.getQueryPath()%>" class="fa fa-file-text"></a></code></td>
                                                    </tr>                                         
                                                    <%

                                                        }
                                                    %>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.panel-body -->
                                    </div>
                                </div>                                  
                            </div>                           
                            <div class="panel-heading" style="background-color:#dae1e6;">
                                Resultados <button class="fa fa-chevron-up" id="resultados-job"></button>
                            </div>
                            <div class="panel-body" style="background-color:#eee;" id="resultados">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <center>Resultados</center>
                                            </div>
                                            <br>
                                            <div class="col-lg-12">                                           

                                                <div class="col-lg-3">
                                                    <div class="form-group">
                                                        <label>Seleccionar todos los registros</label>
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" name="marcarTodo" id="marcarTodoG" />Marcar
                                                            </label>
                                                        </div>    
                                                    </div>            
                                                </div>                                                
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label>Descargar</label>
                                                        <select class="form-control" id="opciones">
                                                            <option value="seq">Secuencias</option>
                                                            <option value="align">Alineamientos</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label>Tipo de secuencia</label>
                                                        <select class="form-control" id="tipoSecuencia">
                                                            <option>AA</option>
                                                            <option>NC</option>
                                                            <option>3P</option>
                                                            <option>5P</option>                                                
                                                        </select>
                                                    </div>                                               
                                                </div>
                                                <div class="col-lg-2">
                                                    <label>Incluir detalle</label>
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" name="proteinas" id="proteina" value="proteina" >Proteinas
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2">           
                                                    <div class="form-group">
                                                        <label>Descargar</label>
                                                        <div class="checkbox">
                                                            <label>
                                                                <button  class="fa fa-download" id="obtenerdatos-genomas"></button>
                                                            </label>
                                                        </div>    
                                                    </div>                                            
                                                </div>
                                            </div>                                               
                                            <!-- /.panel-heading -->
                                            <div class="panel-body">

                                                <div class="dataTable_wrapper">
                                                    <table width="100%" class="table table-striped table-bordered table-hover" id="genomas-blast">
                                                        <thead>
                                                            <tr style="font-size:15px; text-align:left;">
                                                                <th style="text-align:center;"></th>
                                                                <th><span class="glyphicon glyphicon-info-sign" onmouseover="tooltip.pop(this, 'Nombre de la secuencia de entrada', {position: 0})"></span> Query</th>
                                                                <th><span class="glyphicon glyphicon-info-sign" onmouseover="tooltip.pop(this, 'Identificador del gen blanco', {position: 0})"></span> Target</th>
                                                                <th><span class="glyphicon glyphicon-info-sign" onmouseover="tooltip.pop(this, 'Procedencia del gen target acorde a la siguiente nomenclatura: <b>M</b>etagenoma | <b>G</b>enoma - Agua | Sedimento - Profundidad de la muestra', {position: 0})"></span> Fuente</th>
                                                                <th><span class="glyphicon glyphicon-info-sign" onmouseover="tooltip.pop(this, 'Asignación funcional del gen target según BLASTP ', {position: 0})"></span> Definición</th>
                                                                <th><span class="glyphicon glyphicon-info-sign" onmouseover="tooltip.pop(this, 'Clasificación taxonómica del gen target según su definición.', {position: 0})"></span> Taxa</th>
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
                                                                <td style="text-align:center;"><input type="checkbox" value="<%= result.getGen_id()%>" id="checkgenoma"></td>
                                                                <td><%= result.getQuery()%></td>
                                                                <td style="word-break: break-all"><%= result.getGen_id()%></td>
                                                                <td><%= result.getSource()%> <a href="#"><p class="fa fa-flask"></p></a></td>
                                                                <td  style="word-break: break-all"><%= result.getTarget_definition()%></td>
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
                                            </div>
                                            <!-- /.panel-body -->
                                        </div>
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

            <!--SCRIPT PARA MARCAR Y DESMARCAR LOS CHECKS DE LA TABLA GENOMAS-->
            <script>
                $("#marcarTodoG").change(function () {
                    var table = $("#genomas-blast").DataTable();
                    var rows = table.rows().nodes();
                    $('input[type="checkbox"]', rows).prop('checked', this.checked);
                });
            </script> 
            <!--SCRIPT PARA OCULTAR DIV PRINCIPAL DE BLASTJOB-->
            <script>
                $(document).ready(function () {
                    var clic = 1;
                    $("#principal-job").on("click", function () {
                        if (clic == 1) {
                            $('#caebecera-blastjob').hide(); //oculto
                            $('#principal-job').removeClass('fa-chevron-up');//elimina clse del icono up
                            $('#principal-job').addClass('fa-chevron-down');//agrega la clase del icono down
                            clic = clic + 1;
                        } else {
                            $('#caebecera-blastjob').show(); //muestro
                            $('#principal-job').removeClass('fa-chevron-down');//elimina clse del icono down
                            $('#principal-job').addClass('fa-chevron-up');//agrega la clase del icono up
                            clic = 1;
                        }

                    });
                });
            </script>        
            <!--SCRIPT PARA OCULTAR DIV RESULTADOS-->
            <script>
                $(document).ready(function () {
                    var clic = 1;
                    $("#resultados-job").on("click", function () {
                        if (clic == 1) {
                            $('#resultados').hide(); //oculto
                            $('#resultados-job').removeClass('fa-chevron-up');//elimina clse del icono up
                            $('#resultados-job').addClass('fa-chevron-down');//agrega la clase del icono down
                            clic = clic + 1;
                        } else {
                            $('#resultados').show(); //muestro
                            $('#resultados-job').removeClass('fa-chevron-down');//elimina clse del icono down
                            $('#resultados-job').addClass('fa-chevron-up');//agrega la clase del icono up
                            clic = 1;
                        }

                    });
                });
            </script>
    </body>
</html>
