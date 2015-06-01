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
                          where emp.id == id
                          select emp;
                         /* {
                              emp.id,
                              emp.ssn,
                              emp.address,
                              emp.name,
                              emp.state,
                              targetgroup = emp.TargetGroup.description
                          };
            homeGridView.DataSource = empData;
            homeGridView.DataBind();
            */
            var recDocQuery = from emp in db.Employees
                              where emp.id == id
                              select emp;
            homeGridView.DataSource = recDocQuery;
            homeGridView.DataBind();
            //receivedDocumentsList.DataSource = recDocQuery;
            //receivedDocumentsList.DataBind();

            var missingDocQuery = from emp in db.Employees
                                  where emp.id == id
                                  select emp;
           // missingDocumentsList.DataSource = missingDocQuery;
            //missingDocumentsList.DataBind();


            var pendingDocQuery = from emp in db.Employees
                                  where emp.id == id
                                  select emp;
            pendingDocumentsList.DataSource = pendingDocQuery;
            pendingDocumentsList.DataBind();
        }
    }
}