package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DAO9 {
    protected static Connection con;

    public DAO9() {
        if (con == null) {
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try (InputStream in = DAO9.class.getClassLoader().getResourceAsStream("db.properties")) {
                Properties p = new Properties();
                p.load(in);
                String dbUrl = p.getProperty("db.url");
                String dbUser = p.getProperty("db.user");
                String dbPassword = p.getProperty("db.password");

                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
