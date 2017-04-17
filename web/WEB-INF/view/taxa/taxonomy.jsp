<%-- 
    Document   : buscadores
    Created on : 27/01/2017, 01:51:05 PM
    Author     : Jose Pefi
--%>

<%@page import="bobjects.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
  ///  response.setHeader("Cache-Control", "no-cache");
    // response.setHeader("Cache-Control", "no-store");
    // response.setHeader("Pragma", "no-cache");
    // response.setDateHeader("Expires", 0);
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

        <!-- Custom Fonts -->
        <link href="css/ventanaModal.css" rel="stylesheet" type="text/css">


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
        
         <!-- Servir secuencias -->
        <script src="js/taxoSequenceServer.js"></script>


        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>

        <!-- DataTables JavaScript -->
        <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
        <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>  





        <script type="text/javascript">
            var palabraAnterior;
            $(document).ready(function() {
                //var globalTimeout = null;  
                //hacemos focus al campo de búsqueda
                $("#search").focus();
                //comprobamos si se pulsa una tecla
                $("#search").keyup(function(e) {
                    //obtenemos el texto introducido en el campo de búsqueda
                    var consulta = $("#search").val();

                    //var evento= (window.event)?event.keyCode:evt.which;

                    // var isWordCharacter = event.key.length === 1;
                    //backspace || deelte
                    // var isBackspaceOrDelete = (event.keyCode == 8 || event.keyCode == 46);
                    var limite = 2;
                    if ($.isNumeric(consulta)) {
                        limite = 0;
                    }
                    if ((palabraAnterior !== $.trim(consulta)) && consulta.length > limite) {
                        palabraAnterior = $.trim(consulta);
                        clearTimeout($.data(this, 'timer'));
                        var wait = setTimeout(peticion, 750);
                        $(this).data('timer', wait);
                    } else if (consulta.length < 1) {
                        clearTimeout($.data(this, 'timer'));
                        var wait = setTimeout(vacio, 200);
                        $(this).data('timer', wait);
                    }

                    function peticion() {
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
                    }
                    function vacio() {
                        // alert("ya pasaon 2segundos y esta vacio");
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
                var grafica = "false";
                if ($("#graficas").is(':checked')) {
                    grafica = "true";
                }
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
                        taxa: search,
                        grafica: grafica
                    },
                    dataType: "html",
                    beforeSend: function() {
                        //imagen de carga
                         $('#buscador').removeClass('btn btn-default');//
                         $('#buscador').addClass('btn btn-default disabled');//
                         $("#detalles").html("<p align='center'><img src='http://form.cenp.com.br/img/carregando.gif' /></p>");
                    },
                    error: function() {
                        alert("error petición ajax");
                        //borrar(ocultar loading div
                    },
                    success: function(data) {
                        $('#buscador').removeClass('btn btn-default disabled');//
                         $('#buscador').addClass('btn btn-default');//
                        $("#detalles").empty();
                        $("#detalles").append(data);
                         
                    }
                });

            }
        </script>


        <title>TAXA</title>

    </head>
    <body >
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; padding-top:10px; padding-left:0px; padding-right:15px; background-color:#ffffff; z-index:0;">
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
                            <div class="panel" style="border:none;">
                                <label>Buscar Taxón:</label>
                                <div class="input-group custom-search-form" style="z-index:0;">
                                    <input type="text" class="form-control" placeholder="Buscar..." id="search" name="search">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" id="buscador" onclick="buscar()">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>

                                </div>
                                <!-- /.panel-heading -->
                                <div id="resultado" style="position:absolute; z-index:2; background-color:#ffffff;">

                                </div>
                                <!-- .panel-body -->
                            </div>
                        </div>
                        <div class="col-lg-6" >
                            <br>
                            <input type="checkbox" id="graficas"> <label>Generar gráficas</label>


                        </div>
                        <div class="col-lg-1">

                            <!--<input type="text" class="form-control"  id="graficas" name="graficas">-->

                        </div>
                    </div>

                    <div class="col-lg-12">
                        <div class="panel panel-default" >  

                            <!-- /.panel-heading -->
                            <div class="panel-body" style="position:absolute; z-index:1;" id="detalles" style="background-color:#ddd;">


                            </div>

                        </div>
                    </div>



                </div>
                <!-- /#page-wrapper -->

            </div>

            <!-- DataTables JavaScript -->
            <script src="bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
            <script src="bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
            <script src="bower_components/datatables-responsive/js/dataTables.responsive.js"></script>


            <!-- Bootstrap Core JavaScript -->
            <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

            <!-- Metis Menu Plugin JavaScript -->
            <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>

            <!-- Custom Theme JavaScript -->
            <script src="dist/js/sb-admin-2.js"></script>

    </body>
</html>
