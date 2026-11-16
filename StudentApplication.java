import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class StudentApplication {

    public static void getAllStudents(Connection conn) {

    }

    public static void addStudent(Connection conn, String firstName, String lastName, String email,
            String enrollmentDate) {

    }

    public static void updateStudentEmail(Connection conn, int studentID, String newEmail) {

    }

    public static void deleteStudent(Connection conn, int studentID) {

    }

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/studentdb";
        String user = "postgres";
        String password = "snooze20ff";

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Connected to postgreSQL successfully!");
            } else {
                System.out.println("Failed to establish connection.");
            }
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}