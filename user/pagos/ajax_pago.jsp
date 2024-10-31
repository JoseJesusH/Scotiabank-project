


<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base_datos.jsp" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    String idPrestamo = request.getParameter("idPrestamo");
    String fechaPago = request.getParameter("fechaPago");
    String montoPago = request.getParameter("montoPago");
    String estado = request.getParameter("estado");

    double i = 0;
    for (double a = 0; a < 99999999; a++){
        i = i + 1;
    }

    base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
    if (bd.conectar()) {
        try {
            bd.insertarPago(idPrestamo, fechaPago, montoPago, estado);
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
