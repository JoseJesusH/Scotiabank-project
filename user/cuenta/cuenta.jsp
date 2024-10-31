

<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ include file="base_datos.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scotiabank | Proyecto</title>
    <script type="text/javascript" src="ajax_cuenta.js"></script>
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
        <h2>Registro de Cuenta</h2>
        <form method="POST" action="<% request.getServletPath(); %>" onsubmit="return false;">
            <div class="relleno">
                <div class="col_50">
                    <input id="idCliente" name="idCliente" type="hidden" value="<%= idCliente %>">
                    <select name="tipoCuenta" id="tipoCuenta">
                        <option disabled selected>Tipo de Cuenta:</option>
                        <option value="cuenta corriente">Cuenta Corriente</option>
                        <option value="cuenta de deposito a plazo fijo">Cuenta de Depósito a Plazo Fijo</option>
                        <option value="cuenta para jovenes y estudiantes">Cuenta para Jóvenes y Estudiantes</option>
                        <option value="cuenta en moneda extranjera">Cuenta en Moneda Extranjera</option>
                        <option value="cuenta con beneficios especiales">Cuenta con Beneficios Especiales</option>
                        <option value="cuenta para empresa">Cuenta para Empresa</option>
                    </select>
                </div>
                <div class="col_50">
                    <input class="campos" id="saldo" name="saldo" type="text" placeholder="Ingrese monto">
                    <input id="estado" name="estado" type="hidden" value="activa">
                </div>
                <button id="btnAgregar" class="btn" type="submit">Agregar</button>
            </div>
        </form>
    </div>
    <h2>Cuentas Registradas</h2>
    <table id="tablaUsuarios" class="tabla">
        <thead>
            <tr>
                <th>Número de Cuenta</th>
                <th>Tipo de cuenta</th>
                <th>Saldo</th>
                <th>Estado</th>
                <th>Fcha de Apertura</th>
                <th>Transacción</th>
            </tr>
        </thead>
        <tbody id="contenido">
        <%
            base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
            if (bd.conectar()) {
                try {
                     
                    ResultSet clientes = bd.getCuentaId(idCliente);
                    while (clientes.next()) {
                        String idCuenta = clientes.getString("idCuenta");
                        out.println( "<tr>" );
                        out.println( "<td>" + clientes.getString("numeroCuenta") + "</td>" );
                        out.println( "<td>" + clientes.getString("tipoCuenta") + "</td>" );
                        out.println( "<td>" + clientes.getString("saldo") + "</td>" );
                        out.println( "<td>" + clientes.getString("estado") + "</td>" );
                        out.println( "<td>" + clientes.getString("fechaApertura") + "</td>" );
                        out.println( "<td><a href='../transaccion/transaccion.jsp?idCuenta=" + idCuenta + "'>Hacer Transacción</a></td>" );
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
