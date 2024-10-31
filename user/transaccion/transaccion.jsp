

<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ include file="base_datos.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scotiabank | Proyecto</title>
    <script type="text/javascript" src="ajax_transaccion.js"></script>
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
        String idCuenta = request.getParameter("idCuenta");
%>
    <div>
        <form method="post" action="../cuenta/cuenta.jsp">
            <button type="submit"><- Regresar</button>
        </form>
    </div>
    <div class="contenedor">
        <h2>Registro de Transacción</h2>
        <form method="POST" action="<% request.getServletPath(); %>" onsubmit="return false;">
            <div class="relleno">
                <div class="col_50">
                    <input id="idCuenta" name="idCuenta" type="hidden" value="<%= idCuenta %>">
                    <select name="tipoTransaccion" id="tipoTransaccion">
                        <option disabled selected>Tipo de Transacción:</option>
                        <option value="deposito">Deposito</option>
                        <option value="retiro">Retiro</option>
                        <option value="transferencia">Transferencia</option>
                    </select>
                </div>
                <div class="col_50">
                    <input class="campos" id="monto" name="monto" type="text" placeholder="Ingrese monto">
                </div>
                <div class="col_50">
                    <input class="campos" id="idCuentaDestino" name="idCuentaDestino" type="text" placeholder="Ingrese el ID">
                </div>
                <button id="btnAgregar" class="btn" type="submit">Realizar Transacción</button>
            </div>
        </form>
    </div>
    <h2>Transacciones Realizados</h2>
    <table id="tablaUsuarios" class="tabla">
        <thead>
            <tr>
                <th>Tipo de Transacción</th>
                <th>Monto</th>
                <th>Fecha de Transacción</th>
            </tr>
        </thead>
        <tbody id="contenido">
        <%
            base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
            if (bd.conectar()) {
                try {
                     
                    ResultSet clientes = bd.getTransaccionId(idCuenta);
                    while (clientes.next()) {
                        String detalle;
                        if ("transferencia".equals(clientes.getString("tipoTransaccion"))) {
                            detalle = "<td><a href='../transaccion/detalleTransaccion.jsp?idCuentaDestino=" + clientes.getString("idCuentaDestino") + "'>Ver</a></td>";
                        } else {
                            detalle = "<td> - </td>";
                        }
                        out.println( "<tr>" );
                        out.println( "<td>" + clientes.getString("tipoTransaccion") + "</td>" );
                        out.println( "<td>" + clientes.getString("monto") + "</td>" );
                        out.println( "<td>" + clientes.getString("fechaTransaccion") + "</td>" );
                        out.println( detalle );
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
