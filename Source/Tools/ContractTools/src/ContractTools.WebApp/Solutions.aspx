﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Solutions.aspx.cs" Inherits="ContractTools.WebApp.Solutions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="content">
            <table style="width: 100%; text-align: center; background: #f0f0f0; padding: 15px 5px;">
                <tr>
                    <td style="text-align: right; width: 40%">ProjectName
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtDescption" runat="server" Width="120px"></asp:TextBox>
                        <span style="text-align: right; padding: 0 5px 0 70px;">GameID</span>
                        <asp:TextBox ID="txtGameID" runat="server" Width="120px"></asp:TextBox>
                        <strong style="color: Red">*</strong>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">프로젝트 네임스페이스
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtNamespace" runat="server" Width="385px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">DebugAddress
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtUrl" runat="server" Width="385px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">using namespace
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtRefNamespace" runat="server" Width="387px" Height="50px"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">ServerScript
                    </td>
                    <td style="text-align: left;">
                        <asp:DropDownList ID="ddSerUseScript" runat="server" Width="120">
                            <asp:ListItem Value="C#" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="Python"></asp:ListItem>
                            <asp:ListItem Value="Lua"></asp:ListItem>
                        </asp:DropDownList>
                        <span style="text-align: right; padding: 0 5px 0 25px;">ClientScript</span>
                        <asp:DropDownList ID="ddCliUseScript" runat="server">
                            <asp:ListItem Value="Lua">Cocos2d-x of Lua</asp:ListItem>
                            <asp:ListItem Value="Quick" Selected="True">Quick</asp:ListItem>
                            <asp:ListItem Value="C#">Unity3d of C#</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">RRContentType</td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddResponseContentType" runat="server" Width="120">
                            <asp:ListItem Value="0">Stream</asp:ListItem>
                            <asp:ListItem Value="1">Json</asp:ListItem>
                        </asp:DropDownList>
                        <span style="text-align: right; padding: 0 5px 0 25px;">
                            <asp:CheckBox ID="ckIsDParam" runat="server" Checked="True" Text="include d parameter" /></span>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td style="text-align: left; padding-top: 15px;">
                        <asp:Button ID="butSubmit" runat="server" Text="제출" OnClick="butSubmit_Click"  CssClass="btn"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-top: 15px;">

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="grid"
                            DataKeyNames="SlnID,SlnName" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="5%">
                                    <EditItemTemplate>
                                        <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("SlnID") %>'  Width="99%"></asp:Label>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SlnID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="프로젝트솔루션" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="SlnName" runat="server" Text='<%# Bind("SlnName") %>'  Width="99%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSlnName" runat="server" Text='<%# Bind("SlnName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="게임ID" ItemStyle-Width="5%">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="gameid" runat="server" Text='<%# Bind("gameid") %>' Width="99%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblgameid" runat="server" Text='<%# Bind("gameid") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="디버깅주소" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Url" runat="server" Text='<%# Bind("Url") %>' Width="99%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblUrl" runat="server" Text='<%# Bind("Url") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="네임스페이스" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Namespace" runat="server" Text='<%# Bind("Namespace") %>' Width="99%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNamespace" runat="server" Text='<%# Bind("Namespace") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="using namespace" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="RefNamespace" runat="server" TextMode="MultiLine" Text='<%# Bind("RefNamespace") %>' Width="99%" Height="50"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRefNamespace" runat="server" Text='<%# Bind("RefNamespace") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Server Script" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="SerUseScript" runat="server" Width="99%" Text='<%# Bind("SerUseScript") %>'>
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="C#" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="Python"></asp:ListItem>
                                            <asp:ListItem Value="Lua"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSerUseScript" runat="server" Text='<%# Bind("SerUseScript") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="클라이언트스크립트사용" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="CliUseScript" runat="server" Width="99%" Text='<%# Bind("CliUseScript") %>'>
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="Lua">Cocos2d-x of Lua</asp:ListItem>
                                            <asp:ListItem Value="Quick" Selected="True">Quick</asp:ListItem>
                                            <asp:ListItem Value="C#">Unity3d of C#</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCliUseScript" runat="server" Text='<%# Bind("CliUseScript") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="요청상응내용유형" ItemStyle-Width="10%">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="RespContentType" runat="server" Text='<%# Bind("RespContentType") %>' Width="99%">
                                            <asp:ListItem Value="0">Stream</asp:ListItem>
                                            <asp:ListItem Value="1">Json</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRespContentType" runat="server" Text='<%# Bind("RespContentType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="d파라메터를포함한요청" ItemStyle-Width="8%">
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="IsDParam" runat="server" Checked='<%# Bind("IsDParam") %>'></asp:CheckBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsDParam" runat="server" Text='<%# Bind("IsDParam") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="8%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:CommandField HeaderText="操作" ItemStyle-HorizontalAlign="Center" ShowDeleteButton="True"
                                    ShowEditButton="True">
                                    <ItemStyle Width="10%" />
                                </asp:CommandField>
                            </Columns>
                            <AlternatingRowStyle CssClass="grid-row-alt" />
                            <FooterStyle CssClass="grid-row" />
                            <HeaderStyle CssClass="grid-head" />
                            <RowStyle CssClass="grid-row" />
                            <SelectedRowStyle CssClass="grid-row-select" />
                            <EditRowStyle CssClass="grid-row-select" />
                        </asp:GridView>

                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
