
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String dbURL = "jdbc:mysql://localhost:3306/scotiabank";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String action = request.getParameter("action");
    if (action == null) {
        action = "";
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();

        if ("login".equals(action)) {
            String dni = request.getParameter("dni");
            String tarjeta = request.getParameter("tarjeta");
            String claveCaj = request.getParameter("claveCaj");
            String password = request.getParameter("password");

            String query = "SELECT * FROM clientes WHERE dni='" + dni + "' AND tarjeta='" + tarjeta + "' AND claveCaj='" + claveCaj + "' AND password='" + password + "'";
            rs = stmt.executeQuery(query);

            if (rs.next()) {
                HttpSession mySession = request.getSession();
                mySession.setAttribute("idCliente", rs.getString("idCliente"));
                mySession.setAttribute("dni", dni);
                mySession.setAttribute("nombres", rs.getString("nombres"));
                mySession.setAttribute("apellidoPat", rs.getString("apellidoPat"));
                mySession.setAttribute("apellidoMat", rs.getString("apellidoMat"));
                response.sendRedirect("bienvenida.jsp");
            } else {
                out.println("Datos ingresados son incorrectos.");
                out.println("<script>");
                out.println("setTimeout(function() { window.location.href = 'login.jsp'; }, 3000);"); // 3 segundos
                out.println("</script>");
            }
        } else if ("logout".equals(action)) {
            HttpSession mySession = request.getSession(false);
            if (mySession != null) {
                mySession.invalidate();
            }
            response.sendRedirect("login.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scotiabank | Proyecto</title>
    <script type="text/javascript" src="validacion.js"></script>
    <!--<link rel="stylesheet" href="styles.css">-->
</head>
<body>
    <div class="contenedor">
        <a href="index.html">Página Principal</a>
        <h2>¡Te damos la bienvenida!</h2>
        <form method="POST" action="login.jsp?action=login" onsubmit="return login();" >
            <div class="relleno">
                
                <!--
                <div class="col_50">
                        <label for="documento">Elige tu tipo de documento</label>
                        <select name="" id="documento">
                            <option>DNI</option>
                            <option>Carné de Extranjería</option>
                            <option>RUC</option>
                            <option>Pasaporte</option>
                            <option>Permiso Temporal de Permanecia</option>
                            <option>Carné FF.PP.</option>
                            <option>Carné FF.AA.</option>
                            <option>Carné de Cuerpo Diplomático</option>
                            <option>Carné Organismo Internacional</option>
                        </select>
                </div>
                -->

                 <div class="col_50">
                    <label for="dni">Ingresa tu número de documento</label>
                    <input class="campos" id="dni" name="dni" type="text" placeholder="Ingresa tu número de tu tarjeta">
                </div>
                 <div class="col_50">
                    <label for="tarjeta">Ingresa tu número de tu tarjeta</label>
                    <input class="campos" id="tarjeta" name="tarjeta" type="text" placeholder="Ingresa tu número de tu tarjeta">
                </div>
                <div class="col_50">
                    <label for="claveCaj">Ingresa tu clave del cajero</label>
                    <input class="campos" id="claveCaj" name="claveCaj" type="password" placeholder="Ingresa tu clave del cajero">
                </div>
                <!--
                <div class="col_50">
                    <label for="clave">Ingresa el código de verificación - captcha</label>
                    <input class="campos" id="dni" name="dni" type="text" placeholder="Ingresa el código de verificación">
                </div>
                -->
                <div class="col_50">
                    <label for="password">Ingresa la contraseña</label>
                    <input class="campos" id="password" name="password" type="password" placeholder="Ingresa el código de verificación">
                </div>
                <button id="btnLogin" class="btn" type="submit">Iniciar Sesión</button>
            </div>
        </form>
    </div>

</body>
</html>
