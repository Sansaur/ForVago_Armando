package es.cifpcm.forvago_armando.modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class Database {
    public static Connection createConnection(String driver,String url,String user,String password){
        MysqlDataSource mysqlDS;
        try {
            Class.forName(driver);
            mysqlDS = new MysqlDataSource();
            mysqlDS.setURL(url);
            mysqlDS.setUser(user);
            mysqlDS.setPassword(password);
            return mysqlDS.getConnection();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public static Connection createFixedConnection(){
        MysqlDataSource mysqlDS;
        try {
            ResourceBundle rb = ResourceBundle.getBundle("config.conexion");
            Class.forName(rb.getString("database.driver"));
            mysqlDS = new MysqlDataSource();
            mysqlDS.setURL(rb.getString("database.url"));
            mysqlDS.setUser(rb.getString("database.user"));
            mysqlDS.setPassword(rb.getString("database.password"));
            return mysqlDS.getConnection();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
