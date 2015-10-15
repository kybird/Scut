<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ContractCopy.aspx.cs" Inherits="ContractTools.WebApp.ContractCopy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="content">
             <table class="table" style="width: 100%; text-align: center; background: #f0f0f0;padding: 15px 5px;">
                <tr>
                    <td style="text-align: right; width: 40%">
                        현재프로젝트
                    </td>
                    <td style="text-align: left;">
                        <asp:Label ID="lblSlnName" runat="server" Style="text-decoration: underline;font-weight: bold;" />
                        <asp:TextBox ID="txtSlnID" runat="server" Visible="false"></asp:TextBox>
                        <asp:TextBox ID="txtVerID" runat="server" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        패킷ID
                    </td>
                    <td style="text-align: left;">
                        <asp:DropDownList ID="ddContract" runat="server" Width="260px" 
                            AutoPostBack="True" onselectedindexchanged="ddContract_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        프로젝트로복사
                    </td>
                    <td style="text-align: left;">
                        <asp:DropDownList ID="ddlSolution" runat="server" Width="260px" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        새패킷ID
                    </td>
                    <td style="text-align: left;">
                        <asp:TextBox ID="txtCopyID" runat="server" Width="260px"></asp:TextBox>
                        <span style="padding: 0 10px"></span>
                        <asp:Button ID="btnRefesh" runat="server" Text="Refresh" OnClick="btnRefesh_Click" CssClass="btn"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        위치에새로추가
                    </td>
                    <td style="text-align: left;">
                        <asp:DropDownList ID="ddResponseParams" runat="server" Width="260px"></asp:DropDownList>
                    </td>
                </tr>
                <tr><td>&nbsp;</td>
                    <td style="text-align: left;padding-top: 15px;">
                        <asp:Button ID="butSubmit" runat="server" Text="프로토콜복제" OnClick="butSubmit_Click" CssClass="btn"/>
                        <span style="padding: 0 10px"></span>
                        <asp:Button ID="btnCopyParam" runat="server" Text="파라메터복제" OnClick="btnCopyParam_Click" CssClass="btn"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">
                        <span>위치로부터파라메터복사해서</span>
                    </td>
                    <td  style="text-align: left;">
                        <asp:DropDownList ID="ddParamCopyFrom" runat="server" Width="120px"></asp:DropDownList>
                        <span>=></span>
                        <asp:DropDownList ID="ddParamCopyTo" runat="server" Width="120px"></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
