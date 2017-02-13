<%-- 
    Document   : buscadores
    Created on : 27/01/2017, 01:51:05 PM
    Author     : Jose Pefi
--%>

<%@page import="bobjects.Usuario"%>
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
        <!-- Morris Charts CSS -->
        <link href="bower_components/morrisjs/morris.css" rel="stylesheet">
        <!-- Custom Fonts -->
        <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">



        <!-- DataTables CSS -->
        <link href="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">
        <!-- DataTables Responsive CSS -->
        <link href="bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>  

        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>


        <script src="http://maps.google.com/maps/api/js?sensor=false&key=AIzaSyClwGUqp2wGhajPth9e6SIz92XqQRNMi0k"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.gmap.js"></script>
        <script type="text/javascript" src="js/examples.js"></script>

        <script type="text/javascript">

            $(document).ready(function() {

                //hacemos focus al campo de búsqueda
                $("#search").focus();
                //comprobamos si se pulsa una tecla
                $("#search").keyup(function(e) {
                    //obtenemos el texto introducido en el campo de búsqueda
                    var consulta = $("#search").val();
                    var isWordCharacter = event.key.length === 1;
                    //backspace || deelte
                    var isBackspaceOrDelete = (event.keyCode == 8 || event.keyCode == 46);
                    var limite = 2;
                    if ($.isNumeric(consulta)) {
                        limite = 0;
                    }
                    if ((isWordCharacter || isBackspaceOrDelete) && consulta.length > limite) {
                        //hace la búsqueda   
                        $("#resultado").css("display", "block");

                        $.ajax({
                            type: "POST",
                            url: "buscaPalabra",
                            data: {
                                palabra: consulta
                            },
                            dataType: "html",
                            beforeSend: function() {
                                //imagen de carga
                                $("#resultado").html("<p align='center'><img src='http://form.cenp.com.br/img/carregando.gif' /></p>");
                            },
                            error: function() {
                                //  alert("error petición ajax");
                            },
                            success: function(data) {
                                $("#resultado").empty();
                                $("#resultado").append(data);
                            }
                        });
                    } else if (consulta.length < 1) {
                        $("#resultado").css("display", "none");
                    }
                });
            });
        </script>
        <script type="text/javascript">
            function capturar(id) {
                //alert(id);
                //optener
                var divSeleccionado = $("#" + id).text();
                //Asignar
                $("#search").val(divSeleccionado);
                //ocultar
                $("#resultado").css("display", "none");

            }
        </script>
        <script type="text/javascript">
            function buscar() {
                //optener valor del input
                var search = $("#search").val();
                //quitamos los espacios en blanco, inicio-final
                //  var search2 = $.trim(search);
                //sacamos el primer espacio en blanco 
                //  var search3 = search2.indexOf(" ");
                //sacamos el id, que enviaremos como parametro
                //  var search4 = search2.substring(0, search3);
                //alert(search4);
                $.ajax({
                    type: "POST",
                    url: "searchTaxa",
                    data: {
                        taxa: search
                    },
                    dataType: "html",
                    beforeSend: function() {
                        //imagen de carga
                        $("#detalles").html("<p align='center'><img src='http://form.cenp.com.br/img/carregando.gif' /></p>");
                    },
                    error: function() {
                        alert("error petición ajax");
                        //borrar(ocultar loading div
                    },
                    success: function(data) {
                        $("#detalles").empty();
                        $("#detalles").append(data);
                    }
                });

            }
        </script>

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
                    <span class="b1">
                        <span class="b1"><img id="logos" src="images/logotipo4.png" alt="logo" width="85%" height="100px" style="padding-left:10px;" /></span>
                    </span>
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

                    <!--<div class="col-lg-12">
                        <button  class="btn btn-default" id="cargar">Cargar</button>
                    </div>-->
                    <div class="col-lg-12" id="contenido">

                        <div class="col-lg-6">
                            <div class="panel panel-default">
                                <div class="input-group custom-search-form">
                                    <input type="text" class="form-control" placeholder="Buscar..." id="search" name="search">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" onclick="buscar()">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                                <!-- /.panel-heading -->
                                <div id="resultado" >

                                </div>
                                <!-- .panel-body -->
                            </div>
                        </div>
                        <div class="col-lg-6" id="detalles">


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

    </body>
</html>
