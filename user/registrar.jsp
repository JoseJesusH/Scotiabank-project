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

        if ("register".equals(action)) {
            String dni = request.getParameter("dni");
            String nombres = request.getParameter("nombres");
            String apellidoPat = request.getParameter("apellidoPat");
            String apellidoMat = request.getParameter("apellidoMat");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String tarjeta = request.getParameter("tarjeta");
            String claveCaj = request.getParameter("claveCaj");
            String password = request.getParameter("password");

            String query = "INSERT INTO clientes (dni, nombres, apellidoPat, apellidoMat, telefono, email, tarjeta, claveCaj, password) VALUES ('" + dni + "', '" + nombres + "', '" + apellidoPat + "', '" + apellidoMat + "', '" + telefono + "', '" + email + "', '" + tarjeta + "', '" + claveCaj + "', '" + password + "')";
            int rowsAffected = stmt.executeUpdate(query);

            if (rowsAffected > 0) {
                // Registro exitoso
                out.println("<script>");
                out.println("alert('Registro exitoso');");
                out.println("window.location.href = 'login.jsp';");
                out.println("</script>");
            } else {
                // Error en el registro
                out.println("<script>");
                out.println("alert('Error al registrar, inténtelo nuevamente');");
                out.println("window.location.href = 'registrar.jsp';");
                out.println("</script>");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
        <form method="POST" action="registrar.jsp?action=register" onsubmit="return validarRegister();">
            <div class="relleno">
                <div class="col_50">
                    <label for="dni">Ingresa tu número de documento</label>
                    <input class="campos" id="dni" name="dni" type="text" placeholder="Ingresa tu número de tu tarjeta">
                </div>
                <div class="col_50">
                    <label for="nombres">Ingresa tus nombres</label>
                    <input class="campos" id="nombres" name="nombres" type="text" placeholder="Ingresa tus nombres">
                </div>
                <div class="col_50">
                    <label for="apellidoPat">Ingresa tus apellido paterno</label>
                    <input class="campos" id="apellidoPat" name="apellidoPat" type="text" placeholder="Ingresa tu apellido paterno">
                </div>
                <div class="col_50">
                    <label for="apellidoMat">Ingresa tus apellido materno</label>
                    <input class="campos" id="apellidoMat" name="apellidoMat" type="text" placeholder="Ingresa tu apellido materno">
                </div>
                <div class="col_50">
                    <label for="telefono">Ingresa tu número de tu telefono</label>
                    <input class="campos" id="telefono" name="telefono" type="text" placeholder="Ingresa tu número de tu telefono">
                </div>
                <div class="col_50">
                    <label for="email">Ingresa tu número de tu email</label>
                    <input class="campos" id="email" name="email" type="email" placeholder="Ingresa tu correo electronico">
                </div>
                <div class="col_50">
                    <label for="tarjeta">Ingresa tu número de tu tarjeta</label>
                    <input class="campos" id="tarjeta" name="tarjeta" type="text" placeholder="Ingresa tu número de tu tarjeta">
                </div>
                <div class="col_50">
                    <label for="clave">Ingresa tu clave del cajero</label>
                    <input class="campos" id="claveCaj" name="claveCaj" type="password" placeholder="Ingresa tu clave del cajero">
                </div>
                <div class="col_50">
                    <label for="clave">Ingresa la contraseña</label>
                    <input class="campos" id="password" name="password" type="password" placeholder="Ingresa el código de verificación">
                </div>
                <button id="btnRegister" class="btn" type="submit">Registrarse</button>
            </div>
        </form>
    </div>

</body>
</html>
