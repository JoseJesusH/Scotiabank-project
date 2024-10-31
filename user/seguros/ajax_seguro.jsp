


<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base_datos.jsp" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    String idCliente = request.getParameter("idCliente");
    String tipoSeguro = request.getParameter("tipoSeguro");
    String cobertura = request.getParameter("cobertura");
    String primaMensual = request.getParameter("primaMensual");

    double i = 0;
    for (double a = 0; a < 99999999; a++){
        i = i + 1;
    }

    base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
    if (bd.conectar()) {
        try {
            bd.insertarSeguro(idCliente, tipoSeguro, cobertura, primaMensual);
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
