<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="MiniWOTC.Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contents" runat="server">
<h1>Wotc Searching</h1>

    <div class="row">
        <div class="col-sm-offset-2 col-md-offset-2 col-lg-offset-2 col-sm-4 col-md-4 col-lg-4">
            <label>Name:</label>
            <input type="text" class="nameTextBox form-control" />
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-offset-2 col-md-offset-2 col-lg-offset-2 col-sm-4 col-md-4 col-lg-4">
            <label>SSN:</label>
            <input type="text" class="ssnTextBox form-control" />
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-offset-2 col-md-offset-2 col-lg-offset-2 col-sm-4 col-md-4 col-lg-4">
            <a class="searchButton btn btn-primary"><i class="fa fa-search"></i> Search Employees</a>
        </div>
    </div>

    <br />

    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>Name</td>
                        <td>SSN</td>
                        <td>Address</td>
                        <td>State</td>
                        <td>Target Group</td>
                    </tr>
                </thead>
                <tbody id="dataTable">

                </tbody>
            </table>
        </div>
    </div>
    <script>
        $("table").hide();

        $(".searchButton").click(function () {
            var name = $(".nameTextBox"),
                ssn = $(".ssnTextBox"),
                errors = false;
            name.removeClass("errorMissing");
            ssn.removeClass("errorMissing");

            if (!name.val() && !ssn.val()) {
                name.addClass("errorMissing");
                ssn.addClass("errorMissing");
                return;
            }

            var d = JSON.stringify({ name: name.val(), ssn: ssn.val() });

            $.ajax({
                type: "POST",
                url: "Search.aspx/SearchEmployees",
                contentType:"application/json;charset=utf-8",
                dataType: "json",
                data: d,
                success: function (da) {
                    var data = JSON.parse(da.d);
                    $("#dataTable").empty();

                    for (var i = 0; i < data.length; i++) {
                        var html = "<tr>";
                        html += "<td><a href='employeeview.aspx?id=" + data[i].id + "'>" + data[i].name + "</td>";
                        html += "<td>" + data[i].ssn + "</td>";
                        html += "<td>" + data[i].address + "</td>";
                        html += "<td>" + data[i].state + "</td>";
                        html += "<td>" + data[i].targetgroup + "</td>";
                        html += "</tr>";

                        $("#dataTable").append(html);
                    }
                    $("table").show();
                }

            });
        });
    </script>
 
</asp:Content>
