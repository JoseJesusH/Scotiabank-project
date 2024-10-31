


<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scotiabank | Proyecto</title>
</head>
<body>
    
<%
    HttpSession mySession = request.getSession(false);
    if (mySession == null || mySession.getAttribute("nombres") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String idCliente = (String) mySession.getAttribute("idCliente");
        String dni = (String) mySession.getAttribute("dni");
        String nombres = (String) mySession.getAttribute("nombres");
        String apePat = (String) mySession.getAttribute("apellidoPat");
        String apeMat = (String) mySession.getAttribute("apellidoMat");
%>
    <h2>Bienvenido, <%= nombres + " " + apePat + " " + apeMat %>!</h2>
    <form method="post" action="login.jsp?action=logout">
        <button type="submit">Cerrar Sesión</button>
    </form>

    <%
        String contextPath = request.getContextPath();
        String inversiones = contextPath + "/proyecto-scotiabank/user/privadas/inversiones.jsp";
        String moneda = contextPath + "/proyecto-scotiabank/user/privadas/moneda.jsp";
        String servicio = contextPath + "/proyecto-scotiabank/user/privadas/servicio.jsp";
        String tarjetas = contextPath + "/proyecto-scotiabank/user/privadas/tarjetas.jsp";
        String password = contextPath + "/proyecto-scotiabank/user/privadas/password.jsp";
    %>
    <div>
        <ul><a href="cuenta/cuenta.jsp">Cuentas</a></ul>
        <ul><a href="prestamo/prestamo.jsp">Prestamos</a></ul>
        <ul><a href="seguros/seguro.jsp">Seguro</a></ul>
        <ul><a href="<%= inversiones %>">Inversiones</a></ul>
        <ul><a href="<%= moneda %>">Cambio Moneda</a></ul>
        <ul><a href="<%= servicio %>">Servicios</a></ul>
        <ul><a href="<%= tarjetas %>">Tarjetas</a></ul>
        <ul><a href="<%= password %>">Cambiar la contraseña</a></ul>
    </div>

<%
    }
%>

</body>
</html>