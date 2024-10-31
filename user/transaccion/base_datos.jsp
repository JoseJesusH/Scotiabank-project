


<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>

<%
class base_datos {
    private String host;
    private String usua;
    private String pass;
    private String bd;
    private Connection conexion;

    public base_datos(String host, String usua, String pass, String bd) {
        this.host = host;
        this.usua = usua;
        this.pass = pass;
        this.bd = bd;
    }

    public boolean conectar() throws IOException, SQLException, ClassNotFoundException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + this.host + "/" + this.bd + "?useSSL=false";
            this.conexion = DriverManager.getConnection(url, this.usua, this.pass);
            
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public ResultSet getTransaccionId(String idCuenta) throws IOException, SQLException {
        try {
            String query = "SELECT * FROM transacciones WHERE idCuenta = ?";
            PreparedStatement ps = this.conexion.prepareStatement(query);
            ps.setString(1, idCuenta);
            return ps.executeQuery();
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public ResultSet getTransacciones() throws IOException, SQLException {
        try {
            Statement statement = this.conexion.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM transacciones");
            return rs;
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public boolean insertarTransaccion(String idCuenta, String tipoTransaccion, String monto, String fechaTransaccion, String idCuentaDestino) throws IOException, SQLException {
        String query = "INSERT INTO transacciones (idCuenta, tipoTransaccion, monto, fechaTransaccion, idCuentaDestino) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = this.conexion.prepareStatement(query)) {
            if (idCuentaDestino == "" || idCuentaDestino.isEmpty()) {
                ps.setNull(5, java.sql.Types.VARCHAR); // O usa el tipo adecuado según el tipo de columna en tu base de datos
            } else {
                ps.setString(5, idCuentaDestino);
            }
            ps.setString(1, idCuenta);
            ps.setString(2, tipoTransaccion);
            ps.setString(3, monto);
            ps.setString(4, fechaTransaccion);
            
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return false;
        }
    }


    public void cerrar() throws SQLException {
        if (this.conexion != null && !this.conexion.isClosed()) {
            this.conexion.close();
        }
    }
}
%>
