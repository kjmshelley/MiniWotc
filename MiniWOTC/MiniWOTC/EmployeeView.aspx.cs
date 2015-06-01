using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MiniWOTC
{
    public partial class EmployeeView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = 0; 
            string xid = string.Empty;
            xid = Request.QueryString["id"];
            
            if (string.IsNullOrEmpty(xid) || !int.TryParse(xid, out id))
            {
                Response.Redirect("Search.aspx");
            }
            eWotcDB db = new eWotcDB();
            var empData = from emp in db.Employees
                          where emp.ID == id
                          select new
                          {
                              emp.ID,
                              emp.SSN,
                              emp.Address,
                              emp.Name,
                              emp.State,
                              emp.City,
                              CompanyName = emp.Location.Company.Name,
                              LocationName = emp.Location.Name,
                              LocationAddress = emp.Location.Address,
                              LocationCity = emp.Location.City,
                              LocationState = emp.Location.State,
                              targetgroup = emp.TargetGroup.Description
                      
                          };
            homeGridView.DataSource = empData;
            homeGridView.DataBind();
            if(empData != null) 
                title.InnerText = "Employee View - " + empData.ToList()[0].Name;

            locationGridView.DataSource = empData;
            locationGridView.DataBind();
            
            var recDocQuery = from emp in db.EmployeeDocuments
                              where emp.EmployeeId == id
                              select new 
                              {
                                  DocumentName = emp.Document.Document1,
                                  emp.ReceivedDate,
                                  emp.Document.AllowedDays 
                              };
            pendingDocumentsList.DataSource = recDocQuery.Where(x => x.ReceivedDate == null);
            pendingDocumentsList.DataBind();

            missingDocumentsList.DataSource = recDocQuery.Where(x => x.ReceivedDate != null &&  ((x.ReceivedDate ?? DateTime.Now) - DateTime.Now).Days > x.AllowedDays);
            missingDocumentsList.DataBind();

            receivedDocumentsList.DataSource = recDocQuery.Where(x => x.ReceivedDate != null && ((x.ReceivedDate ?? DateTime.Now) - DateTime.Now).Days < x.AllowedDays);
            receivedDocumentsList.DataBind();
            
        }
    }
}