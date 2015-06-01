using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Linq.SqlClient;

namespace MiniWOTC
{
    public partial class Search : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string SearchEmployees(string name, string ssn)
        {
            //extra check
            if (string.IsNullOrEmpty(name) && string.IsNullOrEmpty(ssn))
            {
                return "[{\"error\":\"Name or SSN is Empty\"}]";
            }
            eWotcDB db = new eWotcDB();
            var query =
                from emp in db.Employees
                where SqlMethods.Like(emp.Name, "%" + name + "%")
                where SqlMethods.Like(emp.SSN, "%" + ssn + "%")
                select new
                {
                    emp.ID,
                    emp.SSN,
                    emp.Address,
                    emp.Name,
                    emp.City,
                    emp.State,
                    TargetGroup = emp.TargetGroup.Description
                };
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            return (string)json.Serialize(query);
        }
    }
}