


<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base_datos.jsp" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    String idCuenta = request.getParameter("idCuenta");
    String tipoTransaccion = request.getParameter("tipoTransaccion");
    String monto = request.getParameter("monto");
    String fechaTransaccion = request.getParameter("fechaTransaccion");
    String idCuentaDestino = request.getParameter("idCuentaDestino");

    double i = 0;
    for (double a = 0; a < 99999999; a++){
        i = i + 1;
    }

    base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
    if (bd.conectar()) {
        try {
            bd.insertarTransaccion(idCuenta, tipoTransaccion, monto, fechaTransaccion, idCuentaDestino);
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
