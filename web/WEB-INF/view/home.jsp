<%-- 
    Document   : home
    Created on : 25/08/2016, 05:59:00 PM
    Author     : Jose Peralta
--%>


<%@page import="bobjects.Usuario"%>
<%@page import="bobjects.RegistroResumen"%>
<%@page import="java.lang.String"%>
<%@page import="bobjects.PuntoMapa"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CampanaDAO"%>
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
    //String usuario = (String) sesion.getAttribute("usuario");
    String termino = (String) sesion.getAttribute("terminos");
    // String nombres = (String) sesion.getAttribute("nombres");
    // String apellidos = (String) sesion.getAttribute("apellidos");
    String user = usuario.getCorreo();

    String nombreCompleto = usuario.getNombres() + " " + usuario.getApellidos();
    
    String opcionMapa = request.getParameter("opMapa");

%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>CIGOM-ADMIN</title>

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

        <!---TOlTIPS---->
        <link href="themes/1/tooltip.css" rel="stylesheet" type="text/css" >
        <script src="themes/1/tooltip.js" type="text/javascript"></script> 

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>        

        <!--ALERTAS-->
        <script src="alerta/dist/sweetalert-dev.js"></script>
        <link rel="stylesheet" href="alerta/dist/sweetalert.css">
        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>
        
        <!--id Camapaña-->
        <script src="js/idCampana.js"></script>
        <script src="js/changeMap.js"></script>
        
        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>
        <style>

            .labels {
                color: #fff;
                font-family: "Lucida Grande", "Arial", sans-serif;
                font-size: 7px;

            }

        </style>
        <!-- Page-Level Demo Scripts - Tables - Use for reference -->
        <script>
            $(document).ready(function () {
                $('#dataTables-example').DataTable({
                    responsive: true
                });
            });
        </script>
        <script src="http://maps.google.com/maps/api/js?sensor=false&key=AIzaSyClwGUqp2wGhajPth9e6SIz92XqQRNMi0k"></script>
        <script src="https://cdn.rawgit.com/googlemaps/v3-utility-library/master/markerwithlabel/src/markerwithlabel.js"></script>
        <script>
            function iniciar() {
                //var icono = 'images/punto.png';

                var mapa = new google.maps.Map(document.getElementById('mapa'), {
                    zoom: 6,
                    center: {lat: 22.493025, lng: -88.692168},
                    //mapTypeId: google.maps.MapTypeId.ROADMAP
                    // mapTypeId: google.maps.MapTypeId.SATELLITE
                    mapTypeId: google.maps.MapTypeId.HYBRID
                            //mapTypeId: google.maps.MapTypeId.TERRAIN 
                });


            <%  
                Object puntosObj = request.getAttribute("puntos");
                ArrayList<PuntoMapa> puntos = null;

                if (puntosObj != null) {
                    puntos = (ArrayList<PuntoMapa>) puntosObj;
                }
                if (puntos != null) {
                    for (PuntoMapa p : puntos) {

            %>
                //MARCADOR 
                marker = new google.maps.Marker({
                    map: mapa,
                    draggable: true,
                    animation: google.maps.Animation.DROP,
                    position: {lat: <%= p.getLatitud()%>, lng: <%= p.getLongitud()%>},
                    icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        scale: 3, //tamaño
                        strokeColor: '#f00', //color del borde
                        strokeWeight: 1, //grosor del borde
                        fillColor: '#f00', //color de relleno
                        fillOpacity: 1 // opacidad del relleno
                    }

                });

                marker = new MarkerWithLabel({
                    map: mapa,
                    draggable: true,
                    position: {lat: <%= p.getLatitud()%>, lng: <%= p.getLongitud()%>},
                    raiseOnDrag: true,
                    labelContent: "<%= p.getEtiqueta()%>",
                    labelClass: "labels", // clase CSS labels
                    labelAnchor: new google.maps.Point(-4, 3),
                    labelInBackground: false,
                    icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        scale: 0 //tamaño del marker real, 0 para que no se vea.
                    }
                });
            <%

                    }
                }
            %>


            }
        </script>

        <script>
            function terminos() {
                swal({
                    title: "Desea aceptar terminos y condiciones?",
                    text: "La información generada por la Línea de Acción 4 (Degradación de Hidrocarburos) del proyecto \"Implementación de redes de observación oceanográficas (fisicas, geoquímicas, ecológicas) para la generación de escenarios ante posibles contigencias relacionadas a la exploración y producción de hidrocarburos en auguas profundas del Golfo de México\", financiado por el Fondo Sectorial SENER-CONACyT Hidrocarburos, pertenece a las instituciones que están desarrollando dichas líneas. \nLa consulta, descarga y uso de toda la información es confidencial y para uso exclusivo del proyecto. La utilización de la información mencionada implica el reconocimiento de la autoria y créditos de los desarrolladores",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#2274ba",
                    confirmButtonText: "Si, Acepto!",
                    cancelButtonText: "Cancelar",
                    closeOnConfirm: true,
                    closeOnCancel: false
                },
                        function (isConfirm) {
                            if (isConfirm) {

                                $(function () {
                                    var params = {
                                        nombre: "<%=user%>"
                                    };
                                    $.post('actualizaT', params, function (data) {
                                        swal("Confirmado!", "Bienvenido al sistema:<%=nombreCompleto%>", "success");
                                        //location.href="actualiza.jsp?nombre=";  
                                    });
                                });
                            } else {
                                location.href = "CerrarSesion";
                            }
                        });
            }
        </script>
        <script>
            function funciones() {
                terminos();
                iniciar();
            }
            if (<%=termino%> == "1") {
                window.onload = iniciar;
            } else {
                window.onload = funciones;
            }
        </script> 


    </head>

    <body>
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; padding-top:8px; padding-left:0px; padding-right:15px; background-color:#ffffff;">
                <div class="col-lg-9">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                        <span class="b1">
                            <span class="b1"><img id="logos" src="images/logotipo4.png" alt="logo" width="85%" height="100px" style="padding-left:10px;" /></span>
                        </span>
                        <!--<img id="logos" src="images/logosistema2.png" alt="logo" width="40%" height="60px"  />-->
                    </div>
                </div>
                <!-- /.navbar-header -->

   <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown" style="color: #337ab7">

   <br>

   <i class="fa fa-user fa-fw" ></i>            
                        <%
                            out.print(nombreCompleto);
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
                                <a href="buscadores"><i class="fa fa-edit fa-fw"></i> METAGENOMICA</a>
                            </li>
                            <!--
                            <li>
                                <a href="forms.html"><i class="fa fa-edit fa-fw"></i> SITIOS</a>
                            </li>
                            <li>
                                <a href="/view/analisis.jsp"><i class="fa fa-edit fa-fw"></i> ANALISIS</a>
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
                        <!-- <h1 class="page-header">ADMINISTRADOR</h1>-->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <br>
                <!-- /.row -->
                <div class="row">

                    <div class="col-lg-12" id="mapa" style="width:100%; height:400px">
                    </div>

                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="form-group">
                                    <div class="col-lg-2" style="text-align:center;">
                                        <label>Seleccione la campaña:</label>
                                    </div>
                                    <div class="col-lg-2" style="text-align:left;">
                                       
                                        <select class="form-control" id="campanas" name="campanas">
                                            <%
                                                ArrayList<ArrayList<String>> campanaid = null;
                                                // int c = request.getAttribute("campanaid");
                                                Object campanaidOobj = request.getAttribute("campanaid");

                                                if (campanaidOobj != null) {
                                                    campanaid = (ArrayList<ArrayList<String>>) campanaidOobj;
                                                }
                                                if (campanaid != null) {
                                                    for (int cid = 0; cid < campanaid.size(); cid++) {

                                            %>
                                            <option value="<%= campanaid.get(cid).get(0)%>" disabled selected><%= campanaid.get(cid).get(2)%></option>
                                            <%
                                                        //System.out.println(campanaidOobj);
                                                        //out.println("<h1>" + campana.get(i) + "</h1>"); 
                                                    }
                                                }
                                            %>  

                                            <%
                                                ArrayList<ArrayList<String>> campana = null;

                                                Object campanaOobj = request.getAttribute("campana");

                                                if (campanaOobj != null) {
                                                    campana = (ArrayList<ArrayList<String>>) campanaOobj;
                                                }
                                                if (campana != null) {
                                                    for (int c = 0; c < campana.size(); c++) {

                                                        //out.println("<h1>" + campana.get(i) + "</h1>");  

                                            %>

                                            <option value="<%= campana.get(c).get(0)%>"><%= campana.get(c).get(2)%></option>

                                            <%
                                                    }
                                                }

                                            %>
                                        </select>
                                    </div>


                                   <!-- <div class="col-lg-2">
                                        AGUA: <img src="images/icons/indicadores/agua.png" alt="agua">  

                                    </div>
                                    <div class="col-lg-2">
                                        SEDIMENTO: <img src="images/icons/indicadores/sedimento.png" alt="sedimento">
                                    </div>
                                    <div class="col-lg-2">
                                        AGUA Y SEDIMENTO: <img src="images/icons/indicadores/aguaSed.png" alt="aguasedimento">
                                    </div>
                                    <div class="col-lg-2">       
                                        <select  id="opciones" name="opciones">
                                            
                                            <option value="" disabled selected></option>
                                            <option value="op1" >op1</option>
                                            <option value="op2" >op2</option>
                                        </select> 
                                    </div>-->

                                </div>
                                <br>
                                <br>
                                <%                                    if (campanaidOobj != null) {
                                        campanaid = (ArrayList<ArrayList<String>>) campanaidOobj;
                                    }
                                    if (campanaid != null) {
                                        for (int cid2 = 0; cid2 < campanaid.size(); cid2++) {

                                %>
                                <CENTER><p class="text-primary"><b>RESUMEN DE LA CAMPAÑA: <%= campanaid.get(cid2).get(2)%></b></p></CENTER>
                                    <%
                                            }
                                        }
                                    %>
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                                <div class="dataTable_wrapper">
                                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                        <thead>
                                            <tr align="center">
                                                <th>ESTACIÓN</th>
                                                <th><span class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Máximo de lorofila  o fluorescencia. +/- 150m.', {position: 0})"></span> MAX F</th>
                                                <th><span class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Mínimo de oxígeno (O<sub>2</sub>). +/- 400 m.', {position: 0})"></span> MIN O</th>
                                                <th><span class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Masa de agua intermedia del antártida. En esta profundidad se registra constantemente una densidad entre 26.5 y 26.7. -1000m.', {position: 0})"></span> MIL</th>
                                                <th><span class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Máxima profundidad, se toma a unos 20m antes del sedimento.', {position: 0})"></span> FONDO</th>
                                                <th><span class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Sedimento marino, muestra tomada con nucleador.', {position: 0})"></span> SED</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                ArrayList<RegistroResumen> resumen = null;

                                                Object resumenObj = request.getAttribute("resumen");

                                                if (resumenObj != null) {
                                                    resumen = (ArrayList<RegistroResumen>) resumenObj;
                                                }
                                                if (resumen != null) {
                                                    for (RegistroResumen registro : resumen) {

                                                        //out.println("<h1>" + resumen.get(i) + "</h1>");

                                            %>
                                            <tr class="odd gradeA" align="center">
                                                <td align="middle" style="font-size:18px "><br><%= registro.getEstacion()%></td>
                                                <td>
                                                    <table width="100%" class="table table-striped table-bordered table-hover">
                                                        <tbody>
                                                            <tr align="center">
                                                                <%
                                                                    if (registro.tieneMaxF()) {
                                                                %>
                                                                <td  colspan = "4" > <img src="images/icons/correcto.png" alt="correcto"> </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <td  colspan = "4" > <img src="images/icons/incorrecto.png" alt="incorrecto"> </td>
                                                                    <%
                                                                        }

                                                                    %>
                                                            </tr>                                                         
                                                            <tr align="center">
                                                                <td>A</td>
                                                                <td>M</td>
                                                                <td>G</td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td ><%= registro.getSecuenciasMax()[0]%></td>
                                                                <td ><%= registro.getSecuenciasMax()[1]%></td>
                                                                <td ><%= registro.getSecuenciasMax()[2]%></td>
                                                            </tr> 
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table width="100%" class="table table-striped table-bordered table-hover">
                                                        <tbody>
                                                            <tr align="center">

                                                                <%
                                                                    if (registro.tieneMinO()) {
                                                                %>
                                                                <td  colspan = "4" > <img src="images/icons/correcto.png" alt="correcto"> </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <td  colspan = "4" > <img src="images/icons/incorrecto.png" alt="incorrecto"> </td>
                                                                    <%
                                                                        }

                                                                    %>

                                                            </tr>                                                         
                                                            <tr align="center">
                                                                <td>A</td>
                                                                <td>M</td>
                                                                <td>G</td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td ><%= registro.getSecuenciasMin()[0]%></td>
                                                                <td ><%= registro.getSecuenciasMin()[1]%></td>
                                                                <td ><%= registro.getSecuenciasMin()[2]%></td>
                                                            </tr> 
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table width="100%" class="table table-striped table-bordered table-hover">
                                                        <tbody>
                                                            <tr align="center">

                                                                <%
                                                                    if (registro.tieneMil()) {
                                                                %>
                                                                <td  colspan = "4" > <img src="images/icons/correcto.png" alt="correcto"> </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <td  colspan = "4" > <img src="images/icons/incorrecto.png" alt="incorrecto"> </td>
                                                                    <%
                                                                        }

                                                                    %>

                                                            </tr>                                                         
                                                            <tr align="center">
                                                                <td>A</td>
                                                                <td>M</td>
                                                                <td>G</td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td ><%= registro.getSecuenciasMil()[0]%></td>
                                                                <td ><%= registro.getSecuenciasMil()[1]%></td>
                                                                <td ><%= registro.getSecuenciasMil()[2]%></td>
                                                            </tr> 
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table width="100%" class="table table-striped table-bordered table-hover">
                                                        <tbody>
                                                            <tr align="center">

                                                                <%
                                                                    if (registro.tieneFondo()) {
                                                                %>
                                                                <td  colspan = "4" > <img src="images/icons/correcto.png" alt="correcto"> </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <td  colspan = "4" > <img src="images/icons/incorrecto.png" alt="incorrecto"> </td>
                                                                    <%
                                                                        }

                                                                    %>

                                                            </tr>                                                          
                                                            <tr align="center">
                                                                <td>A</td>
                                                                <td>M</td>
                                                                <td>G</td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td ><%= registro.getSecuenciasFondo()[0]%></td>
                                                                <td ><%= registro.getSecuenciasFondo()[1]%></td>
                                                                <td ><%= registro.getSecuenciasFondo()[2]%></td>
                                                            </tr> 
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table width="100%" class="table table-striped table-bordered table-hover">
                                                        <tbody>
                                                            <tr align="center">

                                                                <%
                                                                    if (registro.tieneSedimento()) {
                                                                %>
                                                                <td  colspan = "4" > <img src="images/icons/correcto.png" alt="correcto"> </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <td  colspan = "4" > <img src="images/icons/incorrecto.png" alt="incorrecto"> </td>
                                                                    <%
                                                                        }

                                                                    %>

                                                            </tr>                                                        
                                                            <tr align="center">
                                                                <td>A</td>
                                                                <td>M</td>
                                                                <td>G</td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td ><%= registro.getSecuenciasSedimento()[0]%></td>
                                                                <td ><%= registro.getSecuenciasSedimento()[1]%></td>
                                                                <td ><%= registro.getSecuenciasSedimento()[2]%></td>
                                                            </tr> 
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <%
                                        /*ArrayList<RegistroResumen> resumen = null;

                                       Object resumenObj = request.getAttribute("resumen");

                                       if (resumenObj != null) {
                                           resumen = (ArrayList<RegistroResumen>) resumenObj;
                                       }
                                       if (resumen != null) {
                                           for (RegistroResumen registro : resumen) {
                                       
                                              out.println("<h1>" + registro.getEstacion() + "</h1>");
                                           }
                                           }*/
                                    %>
                                </div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <!-- /.panel -->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>




    </body>

</html>
