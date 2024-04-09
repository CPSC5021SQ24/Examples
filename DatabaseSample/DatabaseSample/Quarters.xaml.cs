using DatabaseLayer;
using Microsoft.Maui.Controls.Compatibility.Platform.UWP;

namespace DatabaseSample;

public partial class QuartersPage : ContentPage
{
    StudentDB database;
    List<Quarter> allQuarters;
    int currentRow = 0;

    public QuartersPage(StudentDB db)
	{
		database = db;
		InitializeComponent();
        allQuarters = database.GetAllQuarters();
        ShowQuarter();
        ActivateButtons();
	}

    void ShowQuarter()
    {
        if (currentRow < allQuarters.Count)
        {
            this.contentId.Text = allQuarters[currentRow].id;
            this.contentName.Text = allQuarters[currentRow].name;
        }
        else
        {
            this.contentId.Text = "No data";
            this.contentName.Text = "No data";
        }
        this.pageNumber.Text = currentRow.ToString() + "/" + allQuarters.Count.ToString();
    }
 
    private void OnPreviousClicked(object sender, EventArgs e)
    {
        if (currentRow > 0)
            currentRow--;
        ShowQuarter();
        ActivateButtons();
    }

    private void OnNextClicked(object sender, EventArgs e)
    {
        if (currentRow < allQuarters.Count - 1)
            currentRow++;
        ShowQuarter();
        ActivateButtons();
    }

    private void OnAddClicked(object sender, EventArgs e)
    {
        ActivateButtons(true);
        currentRow = allQuarters.Count;
        ShowQuarter();
        this.contentId.Text = "";
        this.contentName.Text = "";
    }

    private void OnSaveClicked(object sender, EventArgs e)
    {
        if ( this.contentId.Text == "" || this.contentName.Text == "")
        {
            ErrorMessage("Need to capture data prior to save");
            return;
        }
        database.InsertQuarter(contentId.Text, contentName.Text);
        allQuarters = database.GetAllQuarters();
        ActivateButtons(false);
    }

    private void OnDeleteClicked(object sender, EventArgs e)
    {
        // TODO: Confirmation
        string id = contentId.Text;
        database.DeleteQuarter(id);
        ErrorMessage(string.Format("Quarter {0} deleted", id));
        allQuarters = database.GetAllQuarters();
        ActivateButtons();
    }

    private void OnCancelClicked(object sender, EventArgs e)
    {
        currentRow = 0;
        ShowQuarter();
        ActivateButtons(false);
    }

    private void OnUpdateClicked(object sender, EventArgs e)
    {
        string id = allQuarters[currentRow].id;
        if ( !id.Equals(contentId.Text) )
        {
            ErrorMessage("Cannot edit the quarter ID");
        }
        database.UpdateQuarter(id, contentName.Text);
        ErrorMessage(string.Format("Quarter {0} updated", id));
        allQuarters = database.GetAllQuarters();
        ActivateButtons();
    }

    private void ErrorMessage(string message)
    {
        lblError.Text = message;
    }

    private void ActivateButtons(bool editing=false)
    {
        btnSave.IsEnabled = editing;
        btnCancel.IsEnabled = editing;
        btnPrevious.IsEnabled = currentRow > 0;
        btnNext.IsEnabled = currentRow < allQuarters.Count - 1;
        btnDelete.IsEnabled = currentRow < allQuarters.Count;
    }
}