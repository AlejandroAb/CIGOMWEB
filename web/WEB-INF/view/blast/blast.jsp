<%-- 
    Document   : blast
    Created on : 24/10/2016, 01:47:02 PM
    Author     : Jose Pefi
--%>

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

        <!--ESCRIPT QUE ACTIVA EL BUSCADOR EN LA TABLA METAGENOMAS-->
        <script>
            $(document).ready(function() {
                $('#tabla-metagenomas').DataTable({
                    responsive: true
                });
            });
        </script>

        <!--ESCRIPT QUE ACTIVA EL BUSCADOR EN LA TABLA GENOMAS-->
        <script>
            $(document).ready(function() {
                $('#tabla-genomas').DataTable({
                    responsive: true
                });
            });
        </script>
        <!--ESCRIPT PARA OBTENER LOS VALORES DEL FORMULARIO-->
        <script type="text/javascript">
            $(document).ready(function() {
                $("#ObtenerVal").click(function() {
                    //saco el valor accediendo al id del input = nombre
                    var nombre = $("#nombre").val();

                    var secuencia = $("#secuencia").val();

                    var algoritmo = $('input:radio[name=algoritmo]:checked').val();

                    var eval = $("#eval").val();

                    // para cada checkbox "chequeado"
                    var resultG = [];
                    var resultMG = [];
                    var i = 0;
                    var j = 0;
                    // para cada checkbox "chequeado"
                    $("input[id^=checkG][type=checkbox]:checked").each(function() {

                        // buscamos el td más cercano en el DOM hacia "arriba"
                        // luego encontramos los td adyacentes a este
                        // $(this).closest('td').siblings().each(function () {

                        // obtenemos el texto del td 
                        // result[i] = $(this).val();
                        //++i;
                        //});

                        resultG[i] = $(this).val();
                        ++i;
                    });

                    $("input[id^=checkMG][type=checkbox]:checked").each(function() {

                        resultMG[j] = $(this).val();
                        ++j;
                    });

                    console.log("IdGenomas: " + resultG.join(','));
                    console.log("IdMetagenosmas: " + resultMG.join(','));
                    console.log("Cadena: " + nombre + ',' + secuencia + ',' + algoritmo + ',' + eval);
                    document.write("<form action=\"blastSearch\" method=post name=\"formOculto\">\n\
                                         <input type=\"hidden\" name=\"idgenomas\" value=" + resultG.join(',') + "> \n\\n\
                                         <input type=\"hidden\" name=\"idmetagenomas\" value=" + resultMG.join(',') + "> \n\\n\
                                         <input type=\"hidden\" name=\"algoritmo\" value=" + algoritmo + "> \n\\n\
                                         <input type=\"hidden\" name=\"evalue\" value=" + eval + "> \n\\n\
                                         <input type=\"hidden\" name=\"name\" value='" + nombre + "'> \n\\n\
                                        <input type=\"hidden\" name=\"inputType\" value=sequence> \n\\n\
                                        <input type=\"hidden\" name=\"seq\" value='" + secuencia + "'> \n\
                                         </form>");
                    document.formOculto.submit();

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
                <div class="navbar-header" style="padding-left:15px;">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!--<span class="b1"><img id="logos" src="images/menu/logos.png" alt="logo" width="95%x" height="95px" /></span>-->
                    <span class="b1"><img id="logos" src="images/menu/logoC.png" alt="logo" width="95%x" height="95px" style="padding-left:60px;" /></span>
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
                                <a href="analisis.jsp"><i class="fa fa-edit fa-fw"></i> ANALISIS</a>
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

                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Crear nueva búsqueda Blast.
                            </div>
                            <div class="panel-body" style="background-color:#eee;">
                                <div class="row">
                                    <form rol="form">
                                        <div class="col-lg-8">

                                            <div class="form-group">
                                                <label>Nombre</label>
                                                <input class="form-control" placeholder="Introduce Texto" id="nombre">
                                            </div>
                                            <div class="form-group">
                                                <label>Introduzca el número de acceso (s), gi (s), o secuencia (s) FASTA</label>
                                                <textarea class="form-control" rows="4" id="secuencia"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label>O, subir archivo</label>
                                                <input type="file">
                                            </div>    
                                        </div>

                                        <div class="col-lg-2">
                                            <label>Titulo de opción</label>
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <!--<label>Radio Buttons</label>-->
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="algoritmo" id="optionsRadios1" value="BLASTN" >BLAST N
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="algoritmo" id="optionsRadios2" value="BLASTP">BLAST P
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="algoritmo" id="optionsRadios2" value="BLASTX">BLAST X
                                                            </label>
                                                        </div>	
                                                        <div class="form-group">
                                                            <label>e.val:</label>
                                                            <input class="form-control" id="eval" >
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <center>Metagenomas</center>
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    Marcar todos
                                                    <input type="checkbox" name="marcarTodo" id="marcarTodoG" /> 
                                                    <br>
                                                    <br>
                                                    <div class="dataTable_wrapper">
                                                        <table width="100%" class="table table-striped table-bordered table-hover" id="tabla-genomas">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Nombre</th>
                                                                    <th>Muestra</th>
                                                                    <th>Estación</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="metas">
                                                                <%
                                                                    ArrayList<ArrayList<String>> metagenomas = null;
                                                                    Object metagenomasOobj = request.getAttribute("metagenomas");

                                                                    if (metagenomasOobj != null) {
                                                                        metagenomas = (ArrayList<ArrayList<String>>) metagenomasOobj;
                                                                    }
                                                                    if (metagenomas != null) {
                                                                        for (int mg = 0; mg < metagenomas.size(); mg++) {

                                                                %> 
                                                                <tr style="text-align: left;" class="meta">
                                                                    <td><input type="checkbox" value="<%= metagenomas.get(mg).get(0)%>" id="checkMG"></td>
                                                                    <td><%= metagenomas.get(mg).get(1)%></td>
                                                                    <td><%= metagenomas.get(mg).get(2)%></td>
                                                                    <td><%= metagenomas.get(mg).get(3)%></td>
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
                                        <div class="col-lg-6">

                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <center>Genomas</center>
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body">
                                                    Marcar todos
                                                    <input type="checkbox" name="marcarTodo" id="marcarTodoMG" /> 
                                                    <br>
                                                    <br>
                                                    <div class="dataTable_wrapper">
                                                        <table width="100%" class="table table-striped table-bordered table-hover" id="tabla-metagenomas">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Nombre</th>
                                                                    <th>Taxa</th>
                                                                    <th>Estación</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tgenomas">
                                                                <%
                                                                    ArrayList<ArrayList<String>> genomas = null;
                                                                    // int c = request.getAttribute("campanaid");
                                                                    Object genomasOobj = request.getAttribute("genomas");

                                                                    if (genomasOobj != null) {
                                                                        genomas = (ArrayList<ArrayList<String>>) genomasOobj;
                                                                    }
                                                                    if (genomas != null) {
                                                                        for (int g = 0; g < genomas.size(); g++) {

                                                                %>   

                                                                <tr style="text-align: center;" class="genomas" id="genoma">
                                                                    <td><input type="checkbox" value="<%= genomas.get(g).get(0)%>" class="boton" id="checkG"></td>
                                                                    <td><%= genomas.get(g).get(1)%></td>
                                                                    <td><%= genomas.get(g).get(2)%></td>
                                                                    <td><%= genomas.get(g).get(3)%></td>
                                                                </tr>

                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="panel-heading">
                                                    Crear nueva búsqueda Blast.
                                                </div>
                                                <div class="panel-body" style="background-color:#eee;">
                                                    <!-- /.panel-body -->
                                                </div>
                                            </div>   

                                            <div class="col-lg-6">
                                                <button type="reset" class="btn btn-default">Limpiar</button>
                                            </div>
                                    </form>

                                    <div class="col-lg-6">
                                        <button  class="btn btn-default" id="ObtenerVal">Buscar</button>
                                    </div>


                                    <!-- /.col-lg-6 (nested) -->

                                    <!-- /.col-lg-4 (nested) -->
                                </div>
                                <!-- /.row (nested) -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <div class="panel-heading">
                            Mis búsquedas
                        </div>
                        <div class="panel-body" style="background-color:#eee;"></div>
                    </div>

                </div>

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!--SCRIPT PARA MARCAR Y DESMARCAR LOS CHECKS DE LA TABLA METAGENOMAS-->
        <script>
            $("#marcarTodoMG").change(function() {
                if ($(this).is(':checked')) {
                    //$("input[type=checkbox]").prop('checked', true); //todos los check del documento
                    $("#tabla-metagenomas input[type=checkbox]").prop('checked', true); //solo los del objeto #marcarMetagenomas
                } else {
                    //$("input[type=checkbox]").prop('checked', false);//todos los check del documento
                    $("#tabla-metagenomas input[type=checkbox]").prop('checked', false);//solo los del objeto #marcarMetagenomas
                }
            });
        </script>

        <!--SCRIPT PARA MARCAR Y DESMARCAR LOS CHECKS DE LA TABLA GENOMAS-->
        <script>
            $("#marcarTodoG").change(function() {
                if ($(this).is(':checked')) {
                    //$("input[type=checkbox]").prop('checked', true); //todos los check del documento
                    $("#tabla-genomas input[type=checkbox]").prop('checked', true); //solo los del objeto #tabla-genomas
                } else {
                    //$("input[type=checkbox]").prop('checked', false);//todos los check del documento
                    $("#tabla-genomas input[type=checkbox]").prop('checked', false);//solo los del objeto #tabla-genomas
                }
            });
        </script>  
    </body>
</html>
