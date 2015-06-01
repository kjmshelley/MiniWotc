using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MiniWOTC
{
    public partial class targetgroupview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            eWotcDB db = new eWotcDB();
            var query = from t in db.TargetGroups
                        select t;
            targetGroupsGridView.DataSource = query;
            targetGroupsGridView.DataBind();
            
            
        }
    }
}