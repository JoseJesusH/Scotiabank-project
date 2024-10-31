


<%@ page import="java.io.StringWriter, java.io.PrintWriter, java.sql.SQLException, java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base_datos.jsp" %>
<%
    response.setContentType("text/html;charset=UTF-8");
    String idCliente = request.getParameter("idCliente");
    String numeroCuenta = request.getParameter("numeroCuenta");
    String tipoCuenta = request.getParameter("tipoCuenta");
    String saldo = request.getParameter("saldo");
    String estado = request.getParameter("estado");
    String fechaApertura = request.getParameter("fechaApertura");

    double i = 0;
    for (double a = 0; a < 99999999; a++){
        i = i + 1;
    }

    base_datos bd = new base_datos("localhost", "root", "", "scotiabank");
    if (bd.conectar()) {
        try {
            bd.insertarCuenta(idCliente, numeroCuenta, tipoCuenta, saldo, estado, fechaApertura);
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
