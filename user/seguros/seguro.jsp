

<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ include file="base_datos.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scotiabank | Proyecto</title>
    <script type="text/javascript" src="ajax_seguro.js"></script>
    <!--<link rel="stylesheet" href="styles.css">-->
</head>
<body>

<%
    HttpSession mySession = request.getSession(false);
    if (mySession == null || mySession.getAttribute("nombres") == null) {
        response.sendRedirect("../login.jsp");
    } else {
        String idCliente = (String) mySession.getAttribute("idCliente");
        String dni = (String) mySession.getAttribute("dni");
        String nombres = (String) mySession.getAttribute("nombres");
        String apePat = (String) mySession.getAttribute("apellidoPat");
        String apeMat = (String) mySession.getAttribute("apellidoMat");
%>
    <div>
        <form method="post" action="../bienvenida.jsp">
            <button type="submit"><- Regresar</button>
        </form>
    </div>
    <div class="contenedor">
        <h2>Registro de Seguro</h2>
        <form method="POST" action="<% request.getServletPath(); %>" onsubmit="return false;">
            <div class="relleno">
                <div class="col_50">
                    <input id="idCliente" name="idCliente" type="hidden" value="<%= idCliente %>">
                    <input class="campos" id="tipoSeguro" name="tipoSeguro" type="text" placeholder="Ingrese el tipo de seguro">
                </div>
                <div class="col_50">
                    <input class="campos" id="cobertura" name="cobertura" type="text" placeholder="Ingrese la cobertura">
                </div>
                <div class="col_50">
                    <input class="campos" id="primaMensual" name="primaMensual" type="text" placeholder="Ingrese monto">
                </div>
                <button id="btnAgregar" class="btn" type="submit">Registrar Seguro</button>
            </div>
        </form>
    </div>
    <h2>Lista de Seguros</h2>
    <table id="tablaUsuarios" class="tabla">
        <thead>
            <tr>
                <th>Tipo de Seguro</th>
                <th>Cobertura</th>
                <th>Prima Mensual</th>
            </tr>
        </thead>
        <tbody id="contenido">
        <%
            base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
            if (bd.conectar()) {
                try {
                     
                    ResultSet clientes = bd.getSeguroId(idCliente);
                     while (clientes.next()) {
                        out.println( "<tr>" );
                        out.println( "<td>" + clientes.getString("tipoSeguro") + "</td>" );
                        out.println( "<td>" + clientes.getString("cobertura") + "</td>" );
                        out.println( "<td>" + clientes.getString("primaMensual") + "</td>" );
                        out.println( "</tr>" );
                    }
                } catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    out.println("<pre>" + sw.toString() + "</pre>");
                } finally {
                    bd.cerrar();
                }
            } else {
                out.println("<tr><td colspan='5'>Error al conectar a la base de datos</td></tr>");
            }
        %>
        </tbody>
    </table>

<%
    }
%>
</body>
</html>
