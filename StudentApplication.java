import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class StudentApplication {

    // calls matching sql function to get the whole table and prints tuples from the
    // returned table
    public static void getAllStudents(Connection conn) throws SQLException {

        var statement = conn.prepareStatement("SELECT * FROM getAllStudents();");
        var result = statement.executeQuery();

        while (result.next()) {
            System.out.println(result.getInt("student_id") + " " + result.getString("first_name") + " "
                    + result.getString("last_name") + " " + result.getString("email") + " "
                    + result.getString("enrollment_date"));
        }

        result.close();
        statement.close();
    }

    // calls matching sql function to add student
    public static int addStudent(Connection conn, String firstName, String lastName, String email,
            String enrollmentDate) throws SQLException {
        var statement = conn.prepareStatement("SELECT addStudent(?, ?, ?, ?::date);");

        statement.setString(1, firstName);
        statement.setString(2, lastName);
        statement.setString(3, email);
        statement.setString(4, enrollmentDate);

        var result = statement.executeQuery();
        result.next();
        int newID = result.getInt(1);
        System.out.println("added student with ID number " + newID);

        result.close();
        statement.close();
        return newID;

    }

    // calls matching sql function to update email
    public static void updateStudentEmail(Connection conn, int studentID, String newEmail) throws SQLException {
        var statement = conn.prepareStatement("SELECT updateStudentEmail(?, ?);");
        statement.setInt(1, studentID);
        statement.setString(2, newEmail);
        var result = statement.executeQuery();

        result.next();
        if (result.getBoolean(1)) {
            System.out.println("updated email for student " + studentID);
        } else {
            System.out.println("no student found with ID number " + studentID);
        }

        result.close();
        statement.close();
    }

    // calls matching sql function to delete a student
    public static void deleteStudent(Connection conn, int studentID) throws SQLException {
        var statement = conn.prepareStatement("SELECT deleteStudent(?);");
        statement.setInt(1, studentID);
        var result = statement.executeQuery();
        result.next();

        if (result.getBoolean(1)) {
            System.out.println("Deleted student " + studentID);
        } else {
            System.out.println("No student found with ID " + studentID);
        }

        result.close();
        statement.close();
    }

    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/School";
        String user = "postgres";
        String password = "snooze20ff";

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Connected to postgreSQL successfully!");

                System.out.println("\ngetAllStudents()");
                getAllStudents(conn);

                System.out.println("\naddStudent()");
                int newID = addStudent(conn, "Alice", "Brown", "alice.brown@example.com", "2026-11-14");

                System.out.println("\nupdateStudentEmail()");
                updateStudentEmail(conn, newID, "alice.new@example.com");

                System.out.println("\ngetAllStudents() after adding + updating");
                getAllStudents(conn);

                System.out.println("\ndeleteStudent()");
                deleteStudent(conn, newID);

                System.out.println("\ngetAllStudents() after adding + updating + removing");
                getAllStudents(conn);
            } else {
                System.out.println("Failed to establish connection.");
            }
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
