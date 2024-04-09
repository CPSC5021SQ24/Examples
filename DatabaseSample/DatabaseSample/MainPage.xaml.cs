using DatabaseLayer;

namespace DatabaseSample
{
    public partial class MainPage : ContentPage
    {
        StudentDB database;

        public MainPage()
        {
            InitializeComponent();
            QuartersBtn.IsEnabled = false;
        }

        private void OnCreateClicked(object sender, EventArgs e)
        {
            database = StudentDB.CreateOrOpen();
            CreateBtn.Text = "Database opened";
            CreateBtn.IsEnabled = false;
            QuartersBtn.IsEnabled = true;
        }

        private void OnQuartersClicked(object sender, EventArgs e)
        {
            App.Current!.MainPage = new QuartersPage(database);
        }
    }

}
