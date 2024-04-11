package com.bguardia.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.sql.*;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
public class QuartersController {

    Connection con;
    StringBuffer output;

    @GetMapping("/quarter")
	public String index() {
        getData();
		return output.toString();
	}    
    
    private int getData()
    {        
        output = new StringBuffer();
        String currentPath = System.getProperty("user.dir");
        Path path = Paths.get(currentPath, "students.db");
        String url = "jdbc:sqlite:" + path.toString();

        try {
            Class.forName("org.sqlite.JDBC");  
            // Step 2:Establishing a connection
             con = DriverManager.getConnection(url);
            createOrOpenDatabase();
            
            // Step 3: Creating statement
            Statement st = con.createStatement();
            
            // Step 4: Executing the query and storing the result
            ResultSet rs = st.executeQuery(
                "select * from quarters");
            
            // Step 5: Processing the results
            output.append("{");
            while (rs.next()) {
                output.append("{ id: '" + rs.getString("quarter_id") + "'}");
                output.append("{ id: '" + rs.getString("quarter_name") + "'}");
            }
            output.append("}");
         
            // Step 6: Closing the connections
            // using close() method to release memory resources
            con.close();
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
        return 0;
    }

    private void createOrOpenDatabase()
    {
        try {
            Statement st = con.createStatement();
            // trick to validate if the table is already created, similar to sys.tables in SQL Server
            ResultSet rs = st.executeQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='quarters'");
            if ( !rs.next())
            {
                    createCoursesTable();
                    createStudentsTable();
                    createQuartersTable();
                    createCoursesGroupsTable();
                    insertQuarters();
            }
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }

    private void createCoursesTable()
    {
        try {
            Statement st = con.createStatement();
            st.execute("CREATE TABLE courses( course_id char(8), subject_name char(255));");
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }

    private void createStudentsTable()
    {
        try {
            Statement st = con.createStatement();
            st.execute("CREATE TABLE students_personal_data ( id int, first_name char(255), last_name char(255), major char(4));");
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }

    private void createCoursesGroupsTable()
    {
        try {
            Statement st = con.createStatement();
            st.execute("CREATE TABLE courses_groups( group_id int, course_id char(8), quarter_id char(4), group_number int);");
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }

    private void createQuartersTable()
    {
        try {
            Statement st = con.createStatement();
            st.execute("CREATE TABLE quarters( quarter_id char(4), quarter_name char(255));");
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }

    private void insertQuarters()
    {
        for ( int year=23; year<=25; year++)
        {
            insertQuarter("WQ" + year, "Winter Quarter " + year);
            insertQuarter("SQ" + year, "Sprint Quarter " + year);
            insertQuarter("RQ" + year, "Undergraduate Summer Quarter" + year);
            insertQuarter("FQ" + year, "Fall Quarter " + year);
        }
    }

    private void insertQuarter(String quarter_id, String quarter_name)
    {
        try {
            String sql="INSERT INTO quarters (quarter_id, quarter_name) VALUES(?, ?)";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, quarter_id);
            st.setString(2, quarter_name);
            st.execute();
        } catch (Exception ex)
        {
            output.append(ex.toString());
        }
    }
}
