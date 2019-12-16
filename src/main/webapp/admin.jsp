<%-- 
    Document   : admin
    Created on : 16/12/2019, 03:20:23 AM
    Author     : Leo González
--%>

<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html lang="es">
    <head>
        <link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
    </head>
    <body>
        
         <div class="container">
            <header>
                <h2>${message}</h2>
                Click on this <strong><a href="/">link</a></strong> to visit another page.
                <br>
                Click on this <strong><a href="pedido">link</a></strong> to visit previous page.
                <br>
                <a href="https://datatables.net/examples/api/select_single_row.html">
                    https://datatables.net/examples/api/select_single_row.html
                </a>
                <br>
                <br>
                <label>Agregar un nuevo Administrador.</label>
                <br>
                <br>
            </header>
                <form method="post" >
                <label>Nombre</label>
                <input type="text" name="nombre" >
                <label>Apellidos</label>
                <input type="text" name="apellidos" >
                <label>Direccion</label>
                <input type="text" name="direccion" >
                <label>Correo</label>
                <input type="text" name="correo" >
                <label>Telefono</label>
                <input type="text" name="telefono" >
                
                <button type= "button" onclick="save()"  >Guardar</button>
            </form>

            <h1>Administradores</h1>
            <h2>Empleando los parámetros Model</h2>
            <div class="starter-template">
                <table class="table table-striped table-hover table-condensed table-bordered">
                    <tr>
                     <th>Id</th>
                     <th>Nombre</th>
                     <th>Apellidos</th>
                       <th>Direccion</th>
                         <th>Correo</th>
                         <th>Telefono</th>
                           
                    </tr>
                    <c:forEach var="adm" items="${admin}">
                     <tr>
                      <td>${adm.id}</td>
                      <td>${adm.nombre}</td>
                      <td>${adm.apellidos}</td>
                      <td>${adm.direccion}</td>
                       <td>${adm.correo}</td>
                       <td>${adm.telefono}</td>
                     </tr>
                    </c:forEach>
                </table>
            </div>


            <h2>Empleando la rest Api</h2>
            <button id="btnDelete" type="button" >Borrar fila seleccionada</button>
            <div class="starter-template">
                <table id="adminTable" class="display">
                   <thead>
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                             <th>Direccion</th>
                              <th>Correo</th>
                              <th>Telefono</th>
                               
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>id</th>
                            <th>nombre</th>
                            <th>apellidos</th>
                            <th>direccion</th>
                            <th>correo</th>
                            <th>telefono</th>
                            
                        </tr>
                    </tfoot>
                </table>
            </div>
--> I love programer

        </div>
                
                
        <script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
    	<script src="${contextPath}/resources/js/datatableadmin.js"></script>
        <script>
            /*
            (function ($) {
                $.fn.serializeFormJSON = function () {
                    var o = {};
                    var a = this.serializeArray();
                    $.each(a, function () {
                        if (o[this.name]) {
                            if (!o[this.name].push) {
                                o[this.name] = [o[this.name]];
                            }
                            o[this.name].push(this.value || '');
                        } else {
                            o[this.name] = this.value || '';
                        }
                    });
                    return o;
                };
            })(jQuery);
            */
                function save() {
                    var urlport = "${site_urlport}";
                    var dataForm = JSON.stringify( $("form").serializeArray().reduce( (f,c) => { f[c.name]=c.value; return f;}, {} ) ) ;
                    console.log( dataForm );
                    console.log (urlport);
                    $.ajax({
                        //url: urlport + "/api/productos", // verificar si se utiliza la ruta y puerto desde application.properties
                        url: "/api/admin",
                        type: 'POST', dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        data: dataForm,
                        success: function(data) {
                            console.log ( data.nombre );
                            //$('#productosTable').dataTable().fnClearTable(); // borrar todo
                            $('#adminTable').dataTable().fnAddData(data);
                        }, 
                        error: function( jqXHR, textStatus, errorThrown ) {
                            alert ("error: " + textStatus );
                        }
                    }).fail( function( jqXHR, textStatus, errorThrown ) {
                        alert ("fail: " + textStatus );
                    });
                }

                $(document).ready(function() {
                    var table = $('#adminTable').DataTable();
                    $('#adminTable tbody').on( 'click', 'tr', function () {
                        if ( $(this).hasClass('selected') ) {
                            $(this).removeClass('selected');
                        }
                        else {
                            table.$('tr.selected').removeClass('selected');
                            $(this).addClass('selected');
                        }
                    } );
                    $('#btnDelete').click( function () {
                        // hacer el borrado visual
                        table.row('.selected').remove().draw( false );
                    } );
                } );                
        </script>
                 
    </body>

</html>