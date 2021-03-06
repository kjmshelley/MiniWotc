﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeView.aspx.cs" Inherits="MiniWOTC.EmployeeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contents" runat="server">
    <style>
 
       
    </style>
    <h1 runat="server" id="title">Employee View</h1>
    <h3>
        <span class="fa-stack fa-lg">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-info fa-stack-1x fa-inverse"></i>
        </span>
        Employee Info
    </h3>
    <asp:GridView ID="homeGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
        <Columns>
            <asp:BoundField DataField="SSN" HeaderText="SSN" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:BoundField DataField="State" HeaderText="State" />
            <asp:BoundField DataField="targetgroup" HeaderText="Target Group" />
        </Columns>
    </asp:GridView>
    <hr />

    <h3>
        <span class="fa-stack fa-lg">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-building-o fa-stack-1x fa-inverse"></i>
        </span>
        Location
    </h3>
    <asp:GridView ID="locationGridView" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
        <Columns>
            <asp:BoundField DataField="CompanyName" HeaderText="Company" />
            <asp:BoundField DataField="LocationName" HeaderText="Name" />
            <asp:BoundField DataField="LocationAddress" HeaderText="Address" />
            <asp:BoundField DataField="LocationCity" HeaderText="City" />
            <asp:BoundField DataField="LocationState" HeaderText="State" />
        </Columns>
    </asp:GridView>
    <hr />

    <h3>
        <span class="fa-stack fa-lg">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-file-text-o fa-stack-1x fa-inverse"></i>
        </span>
        Documents
    </h3>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="panel panel-danger">
                <div class="panel-heading">Missing Documents</div>
                <div class="panel-body">
                    <asp:ListView ID="missingDocumentsList" runat="server" ItemPlaceholderID="missingDocumentsContainer">
                        <LayoutTemplate>
                            <ul class="list-group missingDocuments">
                                <asp:PlaceHolder ID="missingDocumentsContainer" runat="server" />
                            </ul>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <li class="list-group-item"><i class="fa fa-times"></i>&nbsp; <%#Eval("DocumentName")%></li>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="panel panel-warning">
                <div class="panel-heading">Pending Documents</div>
                <div class="panel-body">
                    <asp:ListView ID="pendingDocumentsList" runat="server" ItemPlaceholderID="pendingdDocumentsContainer">
                        <LayoutTemplate>
                            <ul class="list-group pendingdDocuments">
                                <asp:PlaceHolder ID="pendingdDocumentsContainer" runat="server" />
                            </ul>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <li class="list-group-item"><i class="fa fa-clock-o fa-fw"></i>&nbsp; <%#Eval("DocumentName")%></li>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="panel panel-success">
                <div class="panel-heading">Received Documents</div>
                <div class="panel-body">
                    <asp:ListView ID="receivedDocumentsList" runat="server" ItemPlaceholderID="receivedDocumentsContainer">
                        <LayoutTemplate>
                            <ul class="list-group receivedDocuments">
                                <asp:PlaceHolder ID="receivedDocumentsContainer" runat="server" />
                            </ul>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <li class="list-group-item"><i class="fa fa-check-square-o fa-fw"></i>&nbsp; <%#Eval("DocumentName")%></li>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
