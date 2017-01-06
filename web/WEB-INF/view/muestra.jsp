<%-- 
    Document   : muestra
    Created on : 6/01/2017, 11:00:24 AM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

        <script>
            $(document).ready(function () {
                $('#tabla-muestra').DataTable({
                    responsive: true,
                    pageLength: 10

                });
            });
            $(document).ready(function () {
                $('#tabla-muestra2').DataTable({
                    responsive: true,
                    pageLength: 10

                });
            });
        </script> 
        <script src="http://maps.google.com/maps/api/js?sensor=false&key=AIzaSyClwGUqp2wGhajPth9e6SIz92XqQRNMi0k"></script>
        <script type="text/javascript">
        
        $(document).ready(function(){
            
         function mapa() {
            /*var puntoCentral = new google.maps.LatLng(18.983657, -99.234044);
            var opciones = {
                zoom: 7,
                center: puntoCentral,
                mapTypeId: google.maps.MapTypeId.HYBRID
            };
            var div = document.getElementById('punto-mapa');
            var map = new google.maps.Map(div, opciones);
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(18.983657, -99.234044),
                map: map
            });*/
        
        alert("pulsate el link de mapa");
         }
            
        $("#puntoMapa").click(function(){
            
         mapa();   
        //alert("pulsate el link de mapa");
  
        
	});
        });
        
        //window.onload = cargarMapa;
        </script> 
        <title>Muestra</title>
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
                            <li>
                                <a href="Muestra"><i class="fa fa-edit fa-fw"></i> MUESTRA</a>
                            </li>
                            <!--
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
                        <h1 class="page-header">MET-01-E01-ROSETA-MIN.st</h1> 
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <br>
                <!-- /.row -->
                <div class="row">

                    <div class="col-lg-12" id="contenido">
                        <!--<iframe src="krona.html" width=100%; height=500px; frameborder="0"> </iframe>-->

                    <div class="panel panel-default">
                       <!-- <div class="panel-heading">
                            Basic Tabs
                        </div>-->
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#colecta1" data-toggle="tab">Colecta1</a>
                                </li>
                                <li><a href="#colecta2" data-toggle="tab">Colecta2</a>
                                </li>
                                <li><a href="#mapa" id="puntoMapa" data-toggle="tab">Mapa</a>
                                </li>
                                <li><a href="#krona" data-toggle="tab">Krona</a>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane fade in active " id="colecta1">
                                    <br>
                                    <div class="col-md-6">   
                                        <div class="row show-grid">
                                            <div class="col-md-4">Clave colecta:</div>
                                            <div class="col-md-8">MET-O1-E011-ROSETA-MIN</div>
                                        </div>  
                                        <div class="row show-grid">
                                            <div class="col-md-3">Campaña:</div>
                                            <div class="col-md-9">METAGENOMICA -I</div>
                                        </div>
                                         <div class="row show-grid">
                                            <div class="col-md-3">Estación:</div>
                                            <div class="col-md-9">E01</div>
                                        </div> 
                                        <div class="row show-grid">
                                            <div class="col-md-4">Coordenadas:</div>
                                            <div class="col-md-8">23.5°N-96°E</div>
                                        </div>  
                                        <div class="row show-grid">
                                            <div class="col-md-3">Fecha:</div>
                                            <div class="col-md-9">##/##/#### 00:00:00</div>
                                        </div>  
                                        <div class="row show-grid">
                                            <div class="col-md-3">Bioma:</div>
                                            <div class="col-md-9">xxxxxxxxx</div>
                                        </div>                                                                                                            
                                        <div class="row show-grid">
                                            <div class="col-md-5">Material ambiental:</div>
                                            <div class="col-md-7">xxxxxxxxx</div>
                                        </div>     
                                        <div class="row show-grid">
                                            <div class="col-md-5">Caracteristica ambiental:</div>
                                            <div class="col-md-7">xxxxxxxxx</div>
                                        </div>   
                                        <div class="row show-grid">
                                            <div class="col-md-5">Protocolo de muestreo:</div>
                                            <div class="col-md-7">xxxxxxxxxxx</div>
                                        </div>                                                                                                                                    
                                    </div>  

                                    <div class="col-md-6">
                                        <div class="dataTable_wrapper">
                                            <table width="100%" class="table table-striped table-bordered table-hover" id="tabla-muestra">
                                                <thead>
                                                    <tr>
                                                        <th>Variable</th>
                                                        <th>Unidades</th>
                                                        <th>Valor</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Profundidad</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Temperatura</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>PH</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Salinidad</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Fluo</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr> 
                                                    <tr>
                                                        <td>Oxi</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>                                            
                                                </tbody>
                                            </table>
                                        </div>                                                                    
                                    </div>  
                                    <div class="col-md-12">
                                        <div class="panel-body" id="punto-mapa" style="width:100%; height:400px">
                                            
                                        </div>
                                    </div>                                    
                                </div>

                       <div class="tab-pane faden " id="colecta2">
                                    <br>
                        <div class="col-md-6">
                            <div class="panel-body">
                            <div class="list-group" >
                                <a href="#" class="list-group-item">
                                <b>Clave colecta:</b>
                                    <span class="pull-right text-muted small"><em>  MET-O1-E011-ROSETA-MIN</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                   <b> Campaña: </b>
                                    <span class="pull-right text-muted small"><em>METAGENOMICA -I</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                    <b> Estación: </b>
                                    <span class="pull-right text-muted small"><em>E01</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                   <b> Coordenadas: </b>
                                    <span class="pull-right text-muted small"><em>23.5°N-96°E</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                    <b> Fecha: </b>
                                    <span class="pull-right text-muted small"><em>##/##/#### 00:00:00</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                   <b> Bioma </b>
                                    <span class="pull-right text-muted small"><em>xxxxxxxxx</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                     <b> Material ambiental: </b>
                                    <span class="pull-right text-muted small"><em>xxxxxxxxxx</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                    <b> Caracteristica ambiental: </b>
                                    <span class="pull-right text-muted small"><em>xxxxxxxxxx</em>
                                    </span>
                                </a>
                                <a href="#" class="list-group-item">
                                    <b>Protocolo de muestreo:</b>
                                    <span class="pull-right text-muted small"><em>xxxxxxxxx</em>
                                    </span>
                                </a>
                            </div>
                            
                        </div>
                        </div>
                                    <div class="col-md-6">
                                    <div class="panel-body">
                                        <div class="dataTable_wrapper">
                                            <table width="100%" class="table table-striped table-bordered table-hover" id="tabla-muestra2">
                                                <thead>
                                                    <tr>
                                                        <th>Variable</th>
                                                        <th>Unidades</th>
                                                        <th>Valor</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Profundidad</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Temperatura</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>PH</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Salinidad</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>
                                                    <tr>
                                                        <td>Fluo</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr> 
                                                    <tr>
                                                        <td>Oxi</td>
                                                        <td>xx</td>
                                                        <td>xx</td>                                                    
                                                    </tr>                                            
                                                </tbody>
                                            </table>
                                        </div>
                                        </div>                                                                    
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="mapa">
                                    <div class="col-md-12">
                                        <div class="panel-body" id="punto-mapa" style="width:100%; height:400px">
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="krona">
                                    <br>
                                    <iframe src="../WEB-INF/view/home.jsp" width=100%; height=500px; frameborder="0"> </iframe>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->

  
                    </div>

                </div>

            </div>
            <!-- /#page-wrapper -->

        </div>

    </body>
</html>
