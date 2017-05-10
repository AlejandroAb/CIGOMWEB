<%-- 
    Document   : amplicon
    Created on : 22/02/2017, 10:34:34 AM
    Author     : Jose Pefi
--%>

<%@page import="java.util.List"%>
<%@page import="bobjects.ArchivoObj"%>
<%@page import="bobjects.PCRObj"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bobjects.Marcador"%>
<%@page import="bobjects.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    // response.setHeader("Cache-Control", "no-cache");
    // response.setHeader("Cache-Control", "no-store");
    // response.setHeader("Pragma", "no-cache");
    // response.setDateHeader("Expires", 0);
    if (session == null) {
        response.sendRedirect("index.jsp");
    }
    Usuario usuario = (Usuario) sesion.getAttribute("userObj");
    String nombreCompleto = usuario.getNombres() + " " + usuario.getApellidos();
    Object marcadorObj = request.getAttribute("marcador");
    Marcador marcador = marcadorObj != null ? (Marcador) marcadorObj : null;
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

        <!-- Ventana Modal -->
        <link href="css/ventanaModal.css" rel="stylesheet" type="text/css">
        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!---TOlTIPS---->
        <link href="themes/1/tooltip.css" rel="stylesheet" type="text/css">
        <script src="themes/1/tooltip.js" type="text/javascript"></script> 

        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>
        <!--ALERTAS-->
        <script src="alerta/dist/sweetalert-dev.js"></script>
        <link rel="stylesheet" href="alerta/dist/sweetalert.css">

        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>

        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>  
        <script src="js/creaMatriz.js"></script>        

        <script>

            //var idKrona = <%//marcador.getIdMarcador();%>;
            function funcionKrona(idKrona) {
                //alert(idKrona);
                $.ajax({
                    type: "POST",
                    url: "kronaAmp",
                    data: {
                        idkrona: idKrona
                    },
                    dataType: "html",
                    beforeSend: function () {
                        //imagen de carga
                        $("#resultadokrona").html("<p align='center'><img src='http://form.cenp.com.br/img/carregando.gif' /></p>");
                    },
                    error: function () {
                        alert("error petición ajax");
                    },
                    success: function (data) {
                        //alert("success??");
                        $("#resultadokrona").empty();
                        $("#resultadokrona").append(data);
                    }
                });
            }
        </script>
        <script>
            //var idKrona = <%//marcador.getIdMarcador();%>;
            function funcionKrona2(idKrona) {
                $("#resultadokrona3").html("<frameset><iframe src='kronaAmp2?idkrona=" + idKrona + "' width=100%; height=500px; frameborder='0'> </iframe> </frameset>");
            }
        </script>
        <!--SCRIPT PARA OCULTAR DIV DETALLES-->
        <script>

            var clic = 1;
            // $("#icono-info").on("click", function () {
            function desplegar(idArchivo) {
                //alert(idArchivo);
                if ($('#icono' + idArchivo).attr("value") == 0) {
                    $('#' + idArchivo).show(); //muestro
                    $('#icono' + idArchivo).removeClass('fa fa-plus-circle');//elimina clse del fa fa-plus-circle
                    $('#icono' + idArchivo).addClass('fa fa-minus-circle');//agrega la clase del icono fa fa-minus-circle
                    $('#icono' + idArchivo).attr("value", "1");
                    $('#detalle' + idArchivo).css("background-color", "#ddd");

                } else {
                    $('#' + idArchivo).hide(); //oculto
                    $('#icono' + idArchivo).removeClass('fa fa-minus-circle');//elimina clase fa-minus-circle
                    $('#icono' + idArchivo).addClass('fa fa-plus-circle');//agrega la clase fa fa-plus-circle
                    $('#icono' + idArchivo).attr("value", "0");
                    $('#detalle' + idArchivo).css("background-color", "#f9f9f9");
                }
            }
            //});

        </script>
        <title>Amplicon</title>
    </head>
    <body>
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; padding-top:10px; padding-right:15px; background-color:#ffffff; z-index: 0;">
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
                            <li>
                                <a href="homeCamp"><i class="fa fa-edit fa-fw"></i> HOME</a>
                            </li>

                            <li>
                                <a href="blast" ><i class="fa fa-edit fa-fw"></i> BLAST</a>
                            </li>
                            <li>
                                <a href="taxonomia" ><i class="fa fa-edit fa-fw"></i>TAXONOMÍA</a>
                            </li>
                            <li>
                                <a href="matrices"><i class="fa fa-edit fa-fw"></i>MATRICES</a>
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
                <%
                    if (marcador != null) {

                %>
                <div class="row">                     
                    <div class="col-lg-12">

                        <h2 style="color:#337ab7;">Libreria</h2><h4 class="page-header" style="color:#d9534f; margin-top:0px;"><%= marcador.getMarc_name()%></h4> 
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <%
                    }
                %>
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
                                    <li class="active"><a href="#detalles" data-toggle="tab">Detalles</a>
                                    </li>
                                    <li><a href="#secuenciacion" data-toggle="tab">Secuenciación</a>
                                    </li>
                                    <li><a href="#qc" data-toggle="tab">QC</a>
                                    </li>
                                    <li><a href="#archivos" id="boton" data-toggle="tab">Archivos</a>
                                    </li>
                                   <!--<li><a id="div-krona" href="#krona2" data-toggle="tab" onclick="funcionKrona(<%= marcador.getIdMarcador()%>)">KronaPost</a>
                                    </li>-->
                                    <li><a id="div-krona" href="#krona3" data-toggle="tab" onclick="funcionKrona2(<%= marcador.getIdMarcador()%>)">Taxonomía</a>
                                    </li>
                                    <!-- <li><a id="div-krona2" href="#krona" data-toggle="tab">Krona</a>
                                     </li>                                   -->
                                    <li><a id="div-krona3" href="#matriz" data-toggle="tab">Abundancia</a>
                                    </li>                                     
                                </ul>


                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div class="tab-pane fade in active " id="detalles">
                                        <br>

                                        <div class="panel panel-default" style="border:none;">
                                            <!-- /.panel-heading -->
                                            <div class="panel-body">
                                                <div class="table table-striped table-bordered " width="100%">
                                                    <table class="table table-striped">
                                                        <%
                                                            if (marcador != null) {
                                                        %>
                                                        <tbody>

                                                            <tr style="border-top:none;">
                                                                <td style="padding:10px;"><b>Muestra:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><a href = 'showMuestra?idMuestra=<%=marcador.getIdMuestra()%>' target='_blank'><%= marcador.getEtiquetaMuestra()%></a></em></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="padding:10px;"><b>Tipo de librería:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getGenes() + " " + marcador.getSubFragment()%></em></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="padding:10px;"><b>Selección de la librería:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getLibrary_selection()%></em></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="padding:10px;"><b>Configuración de la librería:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getLibrary_layout()%></em></td>
                                                            </tr>                                                               
                                                            <tr>
                                                                <td style="padding:10px;"><b>Descripción de la librería:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%; word-wrap:break-word;"><em><%= marcador.getMarc_desc()%></em></td>
                                                            </tr>    
                                                            <tr>
                                                                <td style="padding:10px;"><b>Comentarios:</b></td>
                                                                <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getComentarios()%></em></td>
                                                            </tr> 

                                                        </tbody>
                                                        <%
                                                            }
                                                        %>
                                                    </table>
                                                </div>
                                                <!-- /.table-responsive -->
                                            </div>
                                            <!-- /.panel-body -->
                                        </div>                               




                                    </div>



                                    <div class="tab-pane faden " id="secuenciacion">
                                        <br>                     

                                        <div class="col-md-6">

                                            <div class="panel panel-default" style="border:none;">
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    <div class="table table-striped table-bordered table-hover" width="100%">
                                                        <table class="table table-striped" >
                                                            <%
                                                                if (marcador != null) {
                                                            %>
                                                            <tbody>

                                                                <tr>
                                                                    <td style="padding:10px;"><b>Tipo de secuenciación:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getNombreTipoSecuenciacion()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><b>Descripción:</b></td>
                                                                    <td style="padding:10px; text-align:left; color:#777; font-size:87%; word-wrap:break-word;"><em><%= marcador.getDescripcionTipoSecuenciacion()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><b>Secuenciador:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getMarca() + "-" + marcador.getModelo()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><b>FW Primer:</b></td>
                                                                    <td style="padding:10px; text-align:left; color:#777; font-size:87%; word-break: break-all; "><em style="font-style: oblique; color:#979a03;"><%= marcador.getPcr().getFw_primer()%></em></td>
                                                                </tr> 
                                                                <tr>
                                                                    <td style="padding:10px;"><b>RV Primer:</b></td>
                                                                    <td style="padding:10px; text-align:left; color:#777; font-size:87%; word-break: break-all; "><em style="font-style: oblique; color:#979a03;"><%= marcador.getPcr().getRv_primer()%></em></td>
                                                                </tr> 
                                                                <tr>
                                                                    <td style="padding:10px;"><b>Vol. DNA: </b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getVolumen()%></em></td>
                                                                </tr>                                       
                                                                <tr>
                                                                    <td style="padding:10px;"><b>Kit:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getPcr().getClean_up_kit()%></em></td>
                                                                </tr>   
                                                                <tr>
                                                                    <td style="padding:10px;"><b>Metodología:</b></td>
                                                                    <td style="padding:10px; text-align:left; color:#777; font-size:87%; word-break: break-all;"><em><%= marcador.getPcr().getClean_up_method()%></em></td>
                                                                </tr>   
                                                                <!-- <tr>
                                                                     <td style="padding:10px;"><b>Condiciones pcr:</b></td>
                                                                     <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getPcr().getPcr_cond()%></em></td>
                                                                 </tr>   -->
                                                            </tbody>
                                                            <%}%>
                                                        </table>
                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.panel-body -->
                                            </div> 

                                        </div>

                                        <div class="col-md-6">
                                            <!-- <div class="panel-body">
                                            <!--<h3>Condiciones pcr</h3>
                                            <hr> -->
                                            <div class="dataTable_wrapper">
                                                <table width="100%" class="table table-striped table-bordered table-hover" >
                                                    <thead>
                                                        <tr>
                                                            <th>Etapa</th>
                                                            <th>Temperatura</th>
                                                            <th>Tiempo</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            if (marcador != null) {
                                                                // ArrayList<String[]> it = marcador.getPcr().getPcr_cond().get(i) ; 
                                                                //for(int x=0;x<cd.size();x++) {
                                                                //System.out.println(cd.get(x));
                                                                //List<String> stockList = new ArrayList<String>();

                                                                for (String[] m : marcador.getPcr().getPcr_cond()) {

                                                        %>
                                                        <tr>

                                                            <td><%= m[0]%></td>
                                                            <td><%= m[1]%></td>
                                                            <td><%= m[2]%></td>                                                    
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div> 

                                    </div>
                                    <div class="tab-pane fade" id="qc">
                                        <br>
                                        <div class="col-md-6">                      
                                            <div class="panel panel-default" style="border:none;">
                                                <!-- /.panel-heading -->
                                                <div class="panel-body" style=" padding-right: 0px; ">
                                                    <div class="table table-striped table-bordered table-hover" width="100%">
                                                        <table class="table table-striped">
                                                            <tbody>
                                                                <tr style="border-top:none;">
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Número de secuencias obtenidas.', {position: 0})"></span> <b>Lecturas:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getReads()%></em></td>                                                                   
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Número de bases nucleotídicas que representan el total de las lecturas obtenidas.', {position: 0})"></span> <b>Bases:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getBases()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Longitud promedio de las lecturas.', {position: 0})"></span> <b>Logitud promedio:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getLong_avg()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Cantidad porcentual de bases G\'s y C\'s dentro de las lecturas', {position: 0})"></span> <b>GC%</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getGc_prc()%></em></td>
                                                                </tr>                                                               
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Valor de calidad promedio de todas las lecturas. Arriba de 20 es aceptable, arriba de 28 es muy buena calidad.', {position: 0})"></span> <b>Promedio QC:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getQc_avg()%></em></td>

                                                                </tr>     

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.panel-body -->
                                            </div>                               

                                        </div>
                                        <div class="col-md-6"> 
                                            <div class="panel panel-default" style="border:none;">
                                                <!-- /.panel-heading -->
                                                <div class="panel-body" style=" padding-left: 0px; ">
                                                    <div class="table table-striped table-bordered table-hover" width="100%">
                                                        <table class="table table-striped">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Número de bases ambiguas o con la letra N.', {position: 0})"></span> <b>n´s%:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getNs_prc()%></em></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Porcentaje de lecturas con promedio de calidad mayor a 20.', {position: 0})"></span> <b>Q20:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getQ20()%></em></td>                                          
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Porcentaje de lecturas con promedio de calidad mayor a 30.', {position: 0})"></span> <b>Q30:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getQ30()%></em></td>                                                     
                                                                </tr>
                                                                <tr>
                                                                    <td style="padding:10px;"><span style="cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, 'Porcentaje de fragmentos que se pudieron extender (lecturas FW y RV).', {position: 0})"></span> <b>Porcentaje combinado:</b></td>
                                                                    <td style="padding:10px; text-align:right; color:#777; font-size:87%;"><em><%= marcador.getStats().getCombined_prc()%></em></td>                                           
                                                                </tr>
                                                                <% }
                                                                %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>  

                                    <div class="tab-pane fade" id="archivos">
                                        <br>
                                        <div class="col-md-12">

                                            <div class="panel panel-default" style="border:none;">
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    <div class="table table-striped table-bordered table-hover" width="100%">
                                                        <table class="table table-striped">

                                                            <thead>
                                                                <tr>
                                                                    <th>Nombre</th>
                                                                    <th>Descripción</th>
                                                                    <th>Descargar</th>
                                                                    <th>Detalles</th>
                                                                </tr>
                                                            </thead

                                                            <tbody>
                                                                <%
                                                                    if (marcador != null) {

                                                                        for (ArchivoObj aobj : marcador.getArchivos()) {

                                                                %>

                                                                <tr style="border-top:none; background-color: #f9f9f9;" id="detalle<%= aobj.getIdArchivo()%>" >
                                                                    <td style="padding:10px; word-break: break-all;"><em><%= aobj.getNombre()%></em></td>
                                                                    <td style="padding:10px;"><em><%= aobj.getDescription()%></em></td>
                                                                    <td style="padding:10px;"><button  class="fa fa-save"></button></td>
                                                                    <td style="padding:10px;"><button value="0" class="fa fa-plus-circle" onclick="desplegar(<%= aobj.getIdArchivo()%>)" id="icono<%= aobj.getIdArchivo()%>"></button></td>
                                                                </tr> 
                                                                <tr style="display:none;" id="<%= aobj.getIdArchivo()%>">

                                                                    <td>
                                                                        <table width="100%" class="table table-striped table-bordered table-hover">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Fecha:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%= aobj.getDate().getFecha()%></em></td>
                                                                                </tr>  
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Alcance:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%= aobj.getAlcance()%></em></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Editor:</b></em></td>
                                                                                    <td style="padding:10px; word-wrap:break-word;"><em><%= aobj.getEditor()%></em></td>
                                                                                </tr> 
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Derechos:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%= aobj.getDerechos()%></em></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Etiquetas:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%=aobj.getTags()%></em></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Tipo de archivo:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%= aobj.getNombreTipo()%></em></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Cheksum:</b></em></td>
                                                                                    <td style="padding:10px; word-break: break-all;"><em><%= aobj.getChecksum()%></em></td>
                                                                                </tr> 
                                                                                <tr>
                                                                                    <td style="padding:10px;"><em><b>Tamaño:</b></em></td>
                                                                                    <td style="padding:10px;"><em><%= aobj.getSize()%></em></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>

                                                                    <td colspan="3">
                                                                        <table width="100%" class="table table-striped table-bordered table-hover">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding:10px; text-align: center;"><em><b>Usuarios:</b></em></td>
                                                                                </tr> 
                                                                                <tr>
                                                                                    <td>
                                                                                        <table width="100%" class="table table-striped table-bordered table-hover" >
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th>Usuario</th>
                                                                                                    <th>Relación</th>
                                                                                                    <th>Comentarios</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <%
                                                                                                    //ArrayList<Usuario> usu = aobj.getUsuarios();
                                                                                                    if (aobj.getUsuarios() != null) {
                                                                                                        for (Usuario u : aobj.getUsuarios()) {
                                                                                                %>
                                                                                                <tr>

                                                                                                    <td><%= u.getNombres() + " " + u.getApellidos()%></td>
                                                                                                    <td><%= u.getAcciones()%></td>
                                                                                                    <td><%= u.getComentarios()%></td>                                                    
                                                                                                </tr>
                                                                                                <%
                                                                                                        }
                                                                                                    }

                                                                                                %>
                                                                                            </tbody>

                                                                                        </table>                                                           
                                                                                    </td>
                                                                                </tr> 
                                                                            </tbody>
                                                                        </table>                                                                        
                                                                    </td>
                                                                    <td>                                                                       
                                                                    </td>
                                                                    <td>                                                                       
                                                                    </td>
                                                                </tr>                                                                
                                                                <%                                                                       }
                                                                    }
                                                                %>

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.panel-body -->
                                            </div> 

                                        </div>
                                    </div>
                                    <!--<div class="tab-pane fade" id="krona2">
                                        <br>
                                        <div id="resultadokrona">


                                        </div>
                                    </div>      -->
                                    <div class="tab-pane fade" id="krona3">
                                        <br>
                                        <div id="resultadokrona3">


                                        </div>
                                    </div>      

                                    <div class="tab-pane fade" id="matriz">
                                        <br>
                                        <h4>Crear Matriz de abundancia</h4> 
                                        <br> 
                                        <div class="row">                         
                                            <div class="col-lg-2">

                                                <label>Nivel Taxonómico</label>
                                                <select id="nivelTaxo" name="nivel" class="form-control">
                                                    <option value="" disabled selected>Select...</option>                                                
                                                    <option value="kingdom">Reino</option>
                                                    <option value="phylum">Filum</option>
                                                    <option value="class">Clase</option>
                                                    <option value="orden">Orden</option>
                                                    <option value="family">Familia</option>
                                                    <option value="genus">Género</option>
                                                    <option value="species">Especie</option>                                                
                                                </select>   
                                                <div class="form-group" id="mGeneros" style="display:none;">

                                                    <div class="radio">
                                                        <label>
                                                            <input type="checkbox" value="norm" name = "degradadores"  id="degradadores">Degradadores de hidrocarburos
                                                        </label>
                                                    </div>

                                                    <div class="radio">
                                                        <label>
                                                            <a href="#popup" id="organismos" >Lista de organismos </a>
                                                        </label>
                                                    </div>
                                                    <div class="modal-wrapper" id="popup">
                                                        <div class="popup-contenedor">
                                                            <div class="panel panel-default">
                                                                <div class="panel-heading">
                                                                    <center><h3><b style="color:#d9534f;">Géneros Degradadores</b></h3></center>
                                                                </div>
                                                                <%
                                                                    Object tabla = request.getAttribute("tabla");
                                                                    String tablaHTML = tabla != null ? (String) tabla : null;
                                                                %>
                                                                <!-- /.panel-heading -->
                                                                <div class="panel-body" >
                                                                    <div class="dataTable_wrapper">
                                                                        <%
                                                                            if (tablaHTML != null) {
                                                                        %>
                                                                        <%= tablaHTML%>

                                                                        <%

                                                                            }
                                                                        %>
                                                                    </div>
                                                                </div>
                                                                <!-- /.panel-body -->
                                                            </div>                               

                                                            <a class="popup-cerrar" href="#">X</a>
                                                        </div>
                                                    </div>


                                                </div>   
                                            </div>
                                            <div class="col-lg-1" >
                                                <br>

                                                <!-- <input type="checkbox" id="nombres" checked> <label>Nombres Cortos</label>-->
                                                <input type="checkbox" id="toFile">
                                                <span style="margin-right:5px; cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, '', {position: 0});"></span> 
                                                <label>Archivo</label>

                                            </div>
                                            <div class="col-lg-1" >
                                                <br>

                                                <input type="checkbox" id="cabecera" > 
                                                <span style="margin-right:5px; cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, '', {position: 0});"></span>
                                                <label>Incluir cabecera</label>
                                            </div>       
                                            <div class="col-lg-3">
                                                <label>Nombre del Organismo</label>
                                                <span style="margin-right:5px; cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, '', {position: 0});"></span>
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <div class="form-group">
                                                            <!--<label>Radio Buttons</label>-->
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" name = "orgName" value = "taxon" id="taxon" checked>Último nivel taxonómico
                                                                </label>
                                                            </div>

                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" value = "filo" name = "orgName" id="filognia" >Filogenia
                                                                </label>
                                                            </div>

                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" name = "orgName" value ="ncbi" id="ncbi">NCBI TAX ID
                                                                </label>
                                                            </div>	

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>    
                                            <div class="col-lg-3">
                                                <label>Conteos</label>
                                                <span style="margin-right:5px; cursor:pointer;" class="glyphicon glyphicon-info-sign" class="tooltip" onmouseover="tooltip.pop(this, '', {position: 0});"></span>
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <div class="form-group">
                                                            <!--<label>Radio Buttons</label>-->
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" value="norm" name = "conteos" checked id="normalizar">Normalizadas
                                                                </label>
                                                            </div>

                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" name = "conteos" value = "crudo" id="crudos" >Cuentas crudas
                                                                </label>
                                                            </div>


                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                        
                                            <div class="col-lg-1">
                                                <br>

                                                <button  class="fa fa-gear" onclick="buscaMatriz(<%=marcador.getIdMarcador()%>)" > Generar</button>
                                            </div>
                                        </div>


                                        <div id="loading"></div>
                                    </div> 

                                </div>


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
<script>
    $(document).ready(function () {
        $("select[name=nivel]").change(function () {
            var niveles = $('select[name=nivel]').val();
            if (niveles == "genus") {

                $("#mGeneros").css("display", " block");
            } else {
                $("#mGeneros").css("display", "none");
            }

        });
    });
</script>
<script>
    $(document).ready(function () {
        $('#lista-organismo').DataTable({
            responsive: true
        });
    });
</script>

</body>
</html>
