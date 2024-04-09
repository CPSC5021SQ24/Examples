using System.Data;
using System.Data.SQLite;
using static Microsoft.Maui.ApplicationModel.Permissions;

namespace DatabaseLayer
{
    // All the code in this file is included in all platforms.
    public class StudentDB
    {
        // The location will be the same place code is running
        private static readonly string testFile = Path.Combine (AppContext.BaseDirectory, "students.db");
        private SQLiteConnection? m_dbConnection;
        private List<Quarter> quarters = [];

        public static StudentDB CreateOrOpen()
        {
            //
            if (!File.Exists(testFile))
            {
                return CreateDatabase();
            }
            return OpenDatabase(testFile);
        }

        public static StudentDB CreateDatabase()
        {
            SQLiteConnection.CreateFile(testFile);
            StudentDB db = OpenDatabase(testFile);
            db.CreateCoursesTable();
            db.CreateStudentsTable();
            db.CreateQuartersTable();
            db.CreateCoursesGroupsTable();
            db.InsertQuarters();
            return db;
        }

        public static StudentDB OpenDatabase(string path)
        {
            StudentDB db = new();

            string connectionString = string.Format("Data Source={0};Version=3;", path);
            db.OpenDb(connectionString);
            return db;
        }

        private void OpenDb(string connectionString)
        {
            m_dbConnection = new SQLiteConnection(connectionString);
            m_dbConnection.Open();
        }

        void CreateStudentsTable()
        {
            SQLiteCommand sqlite_cmd;
            string Createsql = "CREATE TABLE students_personal_data ( id int, first_name char(255), last_name char(255), major char(4));";
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = Createsql;
            sqlite_cmd.ExecuteNonQuery();
        }

        void CreateCoursesTable()
        {
            SQLiteCommand sqlite_cmd;
            string Createsql = "CREATE TABLE courses( course_id char(8), subject_name char(255));";
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = Createsql;
            sqlite_cmd.ExecuteNonQuery();
        }

        void CreateQuartersTable()
        {
            SQLiteCommand sqlite_cmd;
            string Createsql = "CREATE TABLE quarters( quarter_id char(4), quarter_name char(255));";
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = Createsql;
            sqlite_cmd.ExecuteNonQuery();
        }

        void CreateCoursesGroupsTable()
        {
            SQLiteCommand sqlite_cmd;
            string Createsql = "CREATE TABLE courses_groups( group_id int, course_id char(8), quarter_id char(4), group_number int);";
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = Createsql;
            sqlite_cmd.ExecuteNonQuery();
        }

        public void InsertQuarters()
        {
            for ( int year=23; year<=25; year++)
            {
                InsertQuarter("WQ" + year, "Winter Quarter " + year);
                InsertQuarter("SQ" + year, "Sprint Quarter " + year);
                InsertQuarter("RQ" + year, "Undergraduate Summer Quarter" + year);
                InsertQuarter("FQ" + year, "Fall Quarter " + year);
            }
        }

        public void InsertQuarter(string quarter_id, string quarter_name)
        {
            // don't do anything if database is not ready yet
            if (m_dbConnection == null) return;

            SQLiteCommand sqlite_cmd;
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = "INSERT INTO quarters (quarter_id, quarter_name) VALUES(@param1, @param2)";
            sqlite_cmd.CommandType = CommandType.Text;
            sqlite_cmd.Parameters.Add(new SQLiteParameter("@param1", quarter_id));
            sqlite_cmd.Parameters.Add(new SQLiteParameter("@param2", quarter_name));
            sqlite_cmd.ExecuteNonQuery();
        }

        public void DeleteQuarter(string quarter_id)
        {
            // don't do anything if database is not ready yet
            if (m_dbConnection == null) return;

            SQLiteCommand sqlite_cmd;
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = "DELETE FROM quarters WHERE quarter_id=@param1;";
            sqlite_cmd.CommandType = CommandType.Text;
            sqlite_cmd.Parameters.Add(new SQLiteParameter("@param1", quarter_id));
            sqlite_cmd.ExecuteNonQuery();
        }

        public void UpdateQuarter(string quarter_id, string quarter_name)
        {
            // don't do anything if database is not ready yet
            if (m_dbConnection == null) return;

            SQLiteCommand sqlite_cmd;
            sqlite_cmd = m_dbConnection!.CreateCommand();
            sqlite_cmd.CommandText = "UPDATE quarters SET quarter_name=@param2 WHERE quarter_id=@param1;";
            sqlite_cmd.CommandType = CommandType.Text;
            sqlite_cmd.Parameters.Add(new SQLiteParameter("@param1", quarter_id));
            sqlite_cmd.Parameters.Add(new SQLiteParameter("@param2", quarter_name));
            sqlite_cmd.ExecuteNonQuery();
        }

        public List<Quarter> GetAllQuarters()
        {
            quarters.Clear();

            SQLiteCommand sqlite_cmd;
            sqlite_cmd = m_dbConnection!.CreateCommand();
            // TODO: Filters!
            sqlite_cmd.CommandText = "SELECT quarter_id, quarter_name FROM quarters";
            var x = sqlite_cmd.ExecuteReader();
            while (x.Read())
            {
                string id = x.GetFieldValue<string>(0);
                string name = x.GetFieldValue<string>(1);
                Quarter quarter = new(id, name);
                quarters.Add(quarter);
            }
            return quarters;
        }

    }
}
