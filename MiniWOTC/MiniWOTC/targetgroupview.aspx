<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="targetgroupview.aspx.cs" Inherits="MiniWOTC.targetgroupview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contents" runat="server">
<h1>List of Target Groups</h1>
    
<asp:GridView ID="targetGroupsGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
    <Columns>
        <asp:BoundField DataField="TargetGroup1" HeaderText="Target Group" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:BoundField DataField="MaxCredit" HeaderText="Max Credit" />
        
    </Columns>
</asp:GridView>

</asp:Content>
