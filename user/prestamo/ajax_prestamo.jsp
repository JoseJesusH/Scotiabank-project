


<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base_datos.jsp" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    String idCliente = request.getParameter("idCliente");
    String montoPrestamo = request.getParameter("montoPrestamo");
    String fechaInicio = request.getParameter("fechaInicio");
    String plazoMeses = request.getParameter("plazoMeses");
    String tasaInteres = request.getParameter("tasaInteres");
    String estado = request.getParameter("estado");

    double i = 0;
    for (double a = 0; a < 99999999; a++){
        i = i + 1;
    }

    base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
    if (bd.conectar()) {
        try {
            bd.insertarPrestamo(idCliente, montoPrestamo, fechaInicio, plazoMeses, tasaInteres, estado);
            ResultSet clientes = bd.getPrestamoId(idCliente);
            while (clientes.next()) {
                out.println( "<tr>" );
                out.println( "<td>" + clientes.getString("montoPrestamo") + "</td>" );
                out.println( "<td>" + clientes.getString("fechaInicio") + "</td>" );
                out.println( "<td>" + clientes.getString("plazoMeses") + "</td>" );
                out.println( "<td>" + clientes.getString("tasaInteres") + "</td>" );
                out.println( "<td>" + clientes.getString("estado") + "</td>" );
                out.println( "<td><a href='../pagos/pagos.jsp?idPrestamo=" + clientes.getString("idPrestamo") + "'>Ver</a></td>" );
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
