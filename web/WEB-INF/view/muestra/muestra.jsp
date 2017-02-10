<%-- 
    Document   : muestra
    Created on : 6/01/2017, 11:00:24 AM
    Author     : Jose Pefi
--%>

<%@page import="bobjects.Medicion"%>
<%@page import="bobjects.Muestreo"%>
<%@page import="bobjects.Muestra"%>
<%@page import="job.BlastResult"%>
<%@page import="job.Job"%>
<%@page import="bobjects.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.Transacciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    //response.setHeader("Cache-Control", "no-cache");
    //response.setHeader("Cache-Control", "no-store");
    //response.setHeader("Pragma", "no-cache");
    //response.setDateHeader("Expires", 0);
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
            $(document).ready(function() {
                $('#tabla-muestra').DataTable({
                    responsive: true,
                    pageLength: 10

                });
            });
            $(document).ready(function() {
                $('#tabla-muestra2').DataTable({
                    responsive: true,
                    pageLength: 10

                });
            });
        </script> 
        <script src="http://maps.google.com/maps/api/js?sensor=false&key=AIzaSyClwGUqp2wGhajPth9e6SIz92XqQRNMi0k"></script>
        <script type="text/javascript">

            function funciones() {
                mapa();

            }
            window.onload = funciones;

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
                    <%
                        Object muetraObj = request.getAttribute("muestra");
                        Muestra muestra = muetraObj != null ? (Muestra) muetraObj : null;
                        Object mueObj = request.getAttribute("muestreo");
                        Muestreo muestreo = mueObj != null ? (Muestreo) mueObj : null;
                        if (muestreo != null && muestra != null) {

                    %>    

                    <div class="col-lg-12">
                        <h1 class="page-header"><%= muestra.getEtiqueta()%></h1> 
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
                                    <li class="active"><a href="#colecta" data-toggle="tab">Colecta</a>
                                    </li>
                                    <li><a href="#procesamiento" data-toggle="tab">Procesamiento</a>
                                    </li>
                                    <!--<li><a href="#mapaPuntos" id="boton" data-toggle="tab">Mapa</a>
                                    </li>
                                    <li><a href="#krona" data-toggle="tab">Krona</a>
                                    </li>-->
                                </ul>

                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div class="tab-pane fade in active " id="colecta">
                                        <br>
                                        <div class="col-md-6">
                                            <div class="panel-body">
                                                <div class="list-group" width="100%">
                                                    <div  class="list-group-item">
                                                        <b>Clave colecta:</b>
                                                        <span class="pull-right text-muted small" ><em><%= muestreo.getEtiqueta()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Campaña: </b>
                                                        <span class="pull-right text-muted small" ><em><%= muestreo.getIdCampana()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Estación: </b>
                                                        <span class="pull-right text-muted small"><em><%= muestreo.getIdEstacion()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Coordenadas: </b>
                                                        <span class="pull-right text-muted small"><em>Lat: <%= muestreo.getLatitud_r().getCoordenadas()%> </em> <em>Lon:<%= muestreo.getLongitud_r().getCoordenadas()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Fecha: </b>
                                                        <span class="pull-right text-muted small"><em>FI: <%= muestreo.getFechaInicial().toWebString()%></em>  <em>FF: <%= muestreo.getFechaFinal().toWebString()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Bioma </b>
                                                        <span class="pull-right text-muted small"><em><a href="<%= muestreo.getBioma().getUrl()%>"  target="_blank"><%= muestreo.getBioma().getIdTerm()%></a> - <%= muestreo.getBioma().getName()%></em>
                                                        </span>
                                                    </div >
                                                    <div  class="list-group-item">
                                                        <b> Material ambiental: </b>
                                                        <span class="pull-right text-muted small"><em><a href="<%= muestreo.getEnv_material().getUrl()%>"  target="_blank"><%= muestreo.getEnv_material().getIdTerm()%></a> - <%= muestreo.getEnv_material().getName()%></em>
                                                        </span>
                                                    </div>
                                                    <div  class="list-group-item">
                                                        <b> Caracteristica ambiental: </b>
                                                        <span class="pull-right text-muted small"><em><a href="<%= muestreo.getEnv_feature().getUrl()%>"  target="_blank"><%= muestreo.getEnv_feature().getIdTerm()%></a> - <%= muestreo.getEnv_feature().getName()%></em>
                                                        </span>
                                                    </div>
                                                    <script>
                                                        var str = "<%= muestreo.getProtocolo()%>";
                                                        var n = str.length;
                                                        if (n > 220) {
                                                            $("#protocolo").css("padding-bottom", '320px');
                                                            //alert("es mayor que 220");
                                                        } else {
                                                            //alert("es menor que 220");
                                                            $("#protocolo").css("padding-bottom", '100px');
                                                        }

                                                        //alert(n);
                                                    </script>
                                                    <div  id="protocolo" style="">

                                                        <span class="pull-right text-muted small" style="border: 1px solid #ddd; padding: 10px;">
                                                            <b style="color:#000; font-size: 14px;">Protocolo de muestreo:</b>
                                                            <br>
                                                            <p style="text-align:justify;"> 
                                                                <em><%= muestreo.getProtocolo()%></em>
                                                            </p>
                                                        </span>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>       
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

                                                            <%
                                                                for (Medicion m : muestreo.getMediciones()) {
                                                            %>
                                                            <tr>
                                                                <td><%= m.getNombre()%></td>
                                                                <td><%= m.getUnidades()%></td>
                                                                <td><%= m.getMedicion_t1()%></td>                                                    
                                                            </tr>
                                                            <%
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>   
                                            <%
                                             //   Object mue2Obj = request.getAttribute("muestreo");
                                                //  Muestreo muestreo2 = mue2Obj != null ? (Muestreo) mue2Obj : null;
                                                if (muestreo != null) {

                                            %>    

                                            <script>
                                                function mapa() {
                                                    var puntoCentral = new google.maps.LatLng(<%= muestreo.getLatitud_r().getCoordenadas()%>, <%= muestreo.getLongitud_r().getCoordenadas()%>);
                                                    var opciones = {
                                                        zoom: 8,
                                                        center: puntoCentral,
                                                        mapTypeId: google.maps.MapTypeId.HYBRID
                                                    };

                                                    var iconoAncla = 'images/estacion.png';
                                                    var iconoMuestra = 'images/muestra.png';
                                                    var div = document.getElementById('mapa');
                                                    var map = new google.maps.Map(div, opciones);
                                                    var marker = new google.maps.Marker({
                                                        position: new google.maps.LatLng(<%= muestreo.getLatitud_r().getCoordenadas()%>, <%= muestreo.getLongitud_r().getCoordenadas()%>),
                                                        map: map,
                                                        title: "Muestra",
                                                        icon: iconoMuestra
                                                    });
                                                    var marker2 = new google.maps.Marker({
                                                        position: new google.maps.LatLng(<%= muestreo.getLatitud_estacion().getCoordenadas()%>, <%= muestreo.getLongitud_estacion().getCoordenadas()%>),
                                                        map: map,
                                                        title: "Estación",
                                                        icon: iconoAncla
                                                    });

                                                    var flightPlanCoordinates = [
                                                        {lat: <%= muestreo.getLatitud_r().getCoordenadas()%>, lng: <%= muestreo.getLongitud_r().getCoordenadas()%>},
                                                        {lat: <%= muestreo.getLatitud_estacion().getCoordenadas()%>, lng: <%= muestreo.getLongitud_estacion().getCoordenadas()%>}
                                                    ];
                                                    var flightPath = new google.maps.Polyline({
                                                        path: flightPlanCoordinates,
                                                        geodesic: true,
                                                        strokeColor: '#FF0000',
                                                        strokeOpacity: 1.0,
                                                        strokeWeight: 2
                                                    });

                                                    flightPath.setMap(map);
                                                }
                                            </script>

                                            <h2>Mapa</h2>
                                            <hr> 
                                            <p>
                                                <b>Estación:</b> <%= muestreo.getIdEstacion()%> (<%= muestreo.getLatitud_estacion().getCoordenadas()%>,<%= muestreo.getLongitud_estacion().getCoordenadas()%>)
                                            </p>
                                             <p>
                                                 Distancia entre la estaci&oacute;n y el punto de la toma de muestra es:<b> <%= muestreo.getDistanciaEstacion()>1?""+muestreo.getDistanciaEstacion()+" Km.":""+muestreo.getDistanciaEstacion()*1000+"mts."%> </b>
                                            </p>
                                            <%}%>                  
                                            <div id="mapa" style="width:100%; height:200px">

                                            </div>

                                        </div>                                    
                                    </div>



                                    <div class="tab-pane faden " id="procesamiento">
                                        <br>
                                        <div class="col-md-12">
                                            <%
                                                if (muestra != null) {

                                            %>   
                                            <div class="panel-body">
                                                <div class="list-group" >


                                                    <div class="list-group-item">
                                                        <b>Etiqueta de la muestra:</b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getEtiqueta()%></em>
                                                        </span>
                                                    </div>
                                                    <div class="list-group-item">
                                                        <b>Contenedor: </b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getContenedor()%></em>
                                                        </span>
                                                    </div>
                                                    <div class="list-group-item">
                                                        <b>Temperatura contenedor: </b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getcontenedor_temp()%></em>
                                                        </span>
                                                    </div>
                                                    <div class="list-group-item">
                                                        <b>Relación oxigeno: </b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getreal_to_oxy()%></em>
                                                        </span>
                                                    </div>
                                                    <div class="list-group-item">
                                                        <b>Tamaño:</b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getSamp_size()%></em>
                                                        </span>
                                                    </div>
                                                    <script>

                                                        var protocolo = "<%= muestra.getprotocolo()%>";
                                                        var p = protocolo.length;
                                                        if (p > 150)
                                                        {
                                                            $(document).ready(function() {
                                                                $("#protocolo1").css("display", "block");
                                                            });
                                                        } else {
                                                            $(document).ready(function() {
                                                                $("#protocolo2").css("display", "block");
                                                            });
                                                        }
                                                    </script>  

                                                    <div id="protocolo1" style="display:none;">
                                                        <span class="pull-right text-muted small" style="border: 1px solid #ddd; padding: 10px; ">
                                                            <b style="color:#000; font-size: 14px;">Protocolo:</b>
                                                            <br>
                                                            <p style="text-align:justify;">
                                                                <em><%= muestra.getprotocolo()%></em>
                                                            </p>
                                                        </span>
                                                    </div>                                                   

                                                    <div class="list-group-item" id="protocolo2" style="display:none;">
                                                        <b>Protocolo:</b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getprotocolo()%></em>
                                                        </span>
                                                    </div> 
                                                    <script>

                                                        var nota = "<%= muestra.getNotas()%>";
                                                        var n = nota.length;
                                                        if (n > 150)
                                                        {
                                                            $(document).ready(function() {
                                                                $("#notas1").css("display", "block");
                                                            });
                                                        } else {
                                                            $(document).ready(function() {
                                                                $("#notas2").css("display", "block");
                                                            });
                                                        }
                                                    </script>   
                                                    <div id="notas1" style="display:none;">
                                                        <span class="pull-right text-muted small" style="border: 1px solid #ddd; padding: 10px; ">
                                                            <b style="color:#000; font-size: 14px;">Notas:</b>
                                                            <br>
                                                            <p style="text-align:justify;">
                                                                <em><%= muestra.getNotas()%></em>
                                                            </p>
                                                        </span>
                                                    </div>

                                                    <div class="list-group-item" id="notas2" style="display:none;">
                                                        <b>Notas:</b>
                                                        <span class="pull-right text-muted small"><em><%= muestra.getNotas()%></em>
                                                        </span>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <%
                                        }
                                    %>

                                    <div class="tab-pane fade" id="mapaPuntos">
                                        <div class="col-md-12">
                                            <div id="mapadiv" style="width:100%; height:200px">

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
