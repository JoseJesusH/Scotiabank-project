


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

    public ResultSet getPagoId(String idPrestamo) throws IOException, SQLException {
        try {
            String query = "SELECT * FROM pagosProgramados WHERE idPrestamo = ?";
            PreparedStatement ps = this.conexion.prepareStatement(query);
            ps.setString(1, idPrestamo);
            return ps.executeQuery();
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public ResultSet getpagos() throws IOException, SQLException {
        try {
            Statement statement = this.conexion.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM pagosProgramados");
            return rs;
        } catch (SQLException ex) {
            ex.printStackTrace(); 
            return null;
        }
    }

    public boolean insertarPago(String idPrestamo, String fechaPago, String montoPago, String estado) throws IOException, SQLException {
        try {
            String query = "INSERT INTO pagosProgramados (idPrestamo, fechaPago, montoPago, estado) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = this.conexion.prepareStatement(query);
            ps.setString(1, idPrestamo);
            ps.setString(2, fechaPago);
            ps.setString(3, montoPago);
            ps.setString(4, estado);
            
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
