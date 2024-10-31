

<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ include file="base_datos.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scotiabank | Proyecto</title>
    <script type="text/javascript" src="ajax_pago.js"></script>
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
        String idPrestamo = request.getParameter("idPrestamo");
%>
    <div>
        <form method="post" action="../prestamo/prestamo.jsp">
            <button type="submit"><- Regresar</button>
        </form>
    </div>
    <div class="contenedor">
        <h2>Registro de Pago Programado</h2>
        <form method="POST" action="<% request.getServletPath(); %>" onsubmit="return false;">
            <div class="relleno">
                <div class="col_50">
                    <input id="idPrestamo" name="idPrestamo" type="hidden" value="<%= idPrestamo %>">
                    <input class="campos" id="montoPago" name="montoPago" type="text" placeholder="Ingrese el monto de Pago">
                    <input id="estado" name="estado" type="hidden" value="pendiente">
                </div>
                <button id="btnAgregar" class="btn" type="submit">Realizar Pago Programado</button>
            </div>
        </form>
    </div>
    <h2>Pagos Programados</h2>
    <table id="tablaUsuarios" class="tabla">
        <thead>
            <tr>
                <th>Fecha de Pago</th>
                <th>Monto de Pago</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody id="contenido">
        <%
            base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
            if (bd.conectar()) {
                try {
                     
                    ResultSet clientes = bd.getPagoId(idPrestamo);
                    while (clientes.next()) {
                        out.println( "<td>" + clientes.getString("fechaPago") + "</td>" );
                        out.println( "<td>" + clientes.getString("montoPago") + "</td>" );
                        out.println( "<td>" + clientes.getString("estado") + "</td>" );
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
