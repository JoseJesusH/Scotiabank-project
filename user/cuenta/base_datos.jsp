


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

    public ResultSet getCuentaId(String idCliente) throws IOException, SQLException {
        try {
            String query = "SELECT * FROM cuentas WHERE idCliente = ?";
            PreparedStatement ps = this.conexion.prepareStatement(query);
            ps.setString(1, idCliente);
            return ps.executeQuery();
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public ResultSet getCuentas() throws IOException, SQLException {
        try {
            Statement statement = this.conexion.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM cuentas");
            return rs;
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public boolean insertarCuenta(String idCliente, String numeroCuenta, String tipoCuenta, String saldo, String estado, String fechaApertura ) throws IOException, SQLException {
        try {
            String query = "INSERT INTO cuentas (idCliente, numeroCuenta, tipoCuenta, saldo, estado, fechaApertura) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = this.conexion.prepareStatement(query);
            ps.setString(1, idCliente);
            ps.setString(2, numeroCuenta);
            ps.setString(3, tipoCuenta);
            ps.setString(4, saldo);
            ps.setString(5, estado);
            ps.setString(6, fechaApertura);
            
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
