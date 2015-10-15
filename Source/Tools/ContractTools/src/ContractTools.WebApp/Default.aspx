<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ContractTools.WebApp.Default" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>프로토콜도구플랫폼</title>
    <link href="skin.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
        // 이벤트 객체가 들어온다
        function ShowPrompt(objEvent, text) {
            var divObj = document.getElementById("promptDiv");
            divObj.style.visibility = "visible";
            //이한줄코드로 힌트가 마우스포인트 근처에 나타난다.

            divObj.style.left = objEvent.clientX + 5 + "px";   //clientX 윈도우내 마우스의 x좌표값
            divObj.innerHTML = text;
            divObj.style.top = objEvent.clientY + 5 + "px";     //clientY 윈도우내 마우스의 y좌표값
        }
        //힌트란숨기기
        function HiddenPrompt() {
            divObj = document.getElementById("promptDiv");
            divObj.style.visibility = "hidden";
        }
        
        function onCopyCode(id) {
            var t = document.getElementById(id);
            if (t == null) {
                return false;
            }
            t.select();
            if (window.clipboardData) {
                window.clipboardData.clearData();
                window.clipboardData.setData('Text', t.createTextRange().text);
            } else {
                alert('당신의브라우져는 복사기능을지원하지않습니다. 수동복사하세요');
            }
        }

        function OnSearch() {
            var txtSearch = document.getElementById("txtSearch").valueOf || '';
            __doPostBack && __doPostBack("btnSerach", txtSearch);
        }

        function EnterPress(e) {
            var e = e || window.event;
            if(e.keyCode == 13) {
                OnSearch();
            }
        }
    </script>
</head>
<body>
    <div id="promptDiv" class="promptStyle" onmouseout="HiddenPrompt()"></div>
    <form id="form1" runat="server">
        <div class="layout">
            <% if (IsEdit){ %>
            <div class="topbar">
                <ul>
                    <li>
                        <asp:HyperLink ID="hlSolution" runat="server" Target="_top">프로젝트관리</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlVersion" runat="server" Target="_top">스크립트관리</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlEnum" runat="server" Target="_top">열거자관리</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlAgreement" runat="server" Target="_top">카테고리관리</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlContract" runat="server" Target="_top">프로토콜추가</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlContractEdit" runat="server" Target="_top">프로토콜편집</asp:HyperLink></li>
                    <li>
                        <asp:HyperLink ID="hlContractCopy" runat="server" Target="_top">프로토콜복사</asp:HyperLink></li>
                </ul>
            </div>
            <% } %>
            <div class="left">
                <div class="toolbar">
                    <span>
                        <asp:HyperLink ID="hlTopEdit" runat="server" CssClass="edit" ToolTip="편집을열거나닫거나">프로젝트</asp:HyperLink>:</span>
                    <asp:DropDownList ID="ddlSolution" runat="server" Width="120px" AutoPostBack="True" OnSelectedIndexChanged="OnSolutionChanged"></asp:DropDownList>
                    <span>버젼:</span>
                    <asp:DropDownList ID="ddVersion" runat="server" Width="80px" AutoPostBack="True" OnSelectedIndexChanged="OnVersionChanged"></asp:DropDownList>
                    <span>프로토콜:</span>
                    <asp:DropDownList ID="ddlAgreement" runat="server" Width="120px" AutoPostBack="True" OnSelectedIndexChanged="OnAgreementChanged"></asp:DropDownList>
                    <asp:DropDownList ID="ddContract" runat="server" Width="220px" AutoPostBack="True" OnSelectedIndexChanged="OnContractChanged"></asp:DropDownList>
                    <span>필:</span><input type="text" id="txtSearch" name="txtSearch" style="width: 120px" onkeypress="EnterPress(event)" onkeydown="EnterPress()"/>
                    <a class="btn-search" id="btnSerach" onclick="OnSearch()" ></a>
                </div>
                <% if (IsEdit){ %>
                <div class="content">
                    <table style="width: 100%; background: #f0f0f0; padding: 5px;" cellspacing="4">
                        <tr>
                            <td style="width: 25%; text-align: right;"><span class="space">프로토콜:</span></td>
                            <td>
                                <asp:DropDownList ID="ddParamType" runat="server" AutoPostBack="True" Width="100px" OnSelectedIndexChanged="OnParamTypeChanged">
                                    <asp:ListItem Value="1">요청</asp:ListItem>
                                    <asp:ListItem Value="2" Selected="True">응답</asp:ListItem>
                                </asp:DropDownList><span>（Record：순환체시작표식，End：완료표식，Void：폐기，Password：암호화표식）</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;vertical-align: top;">
                                <span class="space">필드타입:</span></td>
                            <td>
                                <asp:DropDownList ID="ddFieldType" runat="server" Width="100px">
                                </asp:DropDownList>
                                <span>위치에추가:</span>
                                <asp:DropDownList ID="ddResponseParams" runat="server" Width="150px">
                                 </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <span class="space">필드명:</span></td>
                            <td>
                                <asp:TextBox ID="txtField" runat="server" Width="300px"></asp:TextBox>
                                <asp:CheckBox runat="server" ID="ckRequired" Text="필수파라메터" Checked="True" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <span class="space">필드설명:</span>
                            </td>
                            <td style="text-align: left;">
                                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="30px" Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr><td style="text-align: right">
                                <span class="space"></span>
                            </td>
                            <td style="padding-top: 5px;">
                                <asp:Button ID="btnParamAdd" runat="server" Text="새파람추가" OnClick="btnParamAdd_Click" CssClass="btn" />
                                <span style="padding:0 5px"></span>
                                <asp:Button ID="btnParamCopy" runat="server" Text="파람복사" OnClick="btnParamCopy_Click" CssClass="btn" AutoPostBack="True" />
                                <span style="padding:0 5px"></span>
                                <asp:Button ID="btnParamRemove" runat="server" Text="파람삭" OnClick="btnParamRemove_Click" CssClass="btn"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                <span>파람복사:</span>
                            </td>
                            <td style="padding-top: 5px;">
                                <asp:DropDownList ID="ddParamCopyFrom" runat="server" Width="150px">
                                 </asp:DropDownList>
                                <span>로</span>
                                <asp:DropDownList ID="ddParamCopyTo" runat="server" Width="150px">
                                 </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
                <% } %>
                <div class="subnav">
                    <span class="title">요청파라메터</span>
                </div>
                <div class="content-grid">
                    <asp:GridView ID="gvReqParams" runat="server" Width="100%" AutoGenerateColumns="False" CssClass="grid"
                        OnRowDataBound="OnGridRowDataBound" OnRowCancelingEdit="OnGridRowCancelingEdit"
                        OnRowEditing="OnGridRowEditing" OnRowUpdating="OnGridRowUpdating">
                        <Columns>
                            <asp:TemplateField Visible="False">
                                <EditItemTemplate>
                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메터명" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtField" runat="server" Text='<%# Bind("Field") %>' Width="90%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabField" runat="server" Text='<%# Bind("Field") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메터타입" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="droFieldType" runat="server" SelectedValue='<%# Bind("FieldTypeId") %>'
                                        Width="90%"><asp:ListItem Value="-1">Password</asp:ListItem>
                                        <asp:ListItem Value="1">Int</asp:ListItem>
                                        <asp:ListItem Value="2">String</asp:ListItem>
                                        <asp:ListItem Value="3">Short</asp:ListItem>
                                        <asp:ListItem Value="4">Byte</asp:ListItem>
                                        <asp:ListItem Value="7">Void</asp:ListItem>
                                        <asp:ListItem Value="8">Long</asp:ListItem>
                                        <asp:ListItem Value="9">Bool</asp:ListItem>
                                        <asp:ListItem Value="10">Float</asp:ListItem>
                                        <asp:ListItem Value="11">Double</asp:ListItem>
                                        <asp:ListItem Value="12">Date</asp:ListItem>
                                        <asp:ListItem Value="13">UInt</asp:ListItem>
                                        <asp:ListItem Value="14">UShort</asp:ListItem>
                                        <asp:ListItem Value="15">ULong</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabFieldType" runat="server" Text='<%# Bind("FieldTypeId") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="5%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="필수파라메터" ItemStyle-Width="5%">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="droRequired" runat="server" SelectedValue='<%# Bind("Required") %>'
                                        Width="90%">
                                        <asp:ListItem Value="False">False</asp:ListItem>
                                        <asp:ListItem Value="True">True</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabRrequired" runat="server" Text='<%# Bind("Required") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="5%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="기본값" ItemStyle-Width="5%">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFieldValue" runat="server" Text='<%# Bind("FieldValue") %>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabFieldValue" runat="server" Text='<%# Bind("FieldValue") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="5%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메타설명" ItemStyle-Width="16%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="hiDescption" runat="server" Text='<%# Bind("Descption") %>' Width="90%" Visible="False"></asp:TextBox>
                                    <asp:TextBox ID="txtDescption" runat="server" Text='<%# Bind("Remark") %>' Width="90%" TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabDescption" runat="server" Text='<%# Bind("Descption") %>'></asp:Label>
                                    <asp:Label ID="LabRemark" runat="server" Text='<%# Bind("Remark") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="16%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" Width="6%"></ItemStyle>
                            </asp:CommandField>
                            <asp:TemplateField ShowHeader="False" HeaderText="조작" ItemStyle-Width="4%" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" OnClientClick="return confirm('정말삭제합니까')"
                                        CommandArgument='<%#Eval("id")%>' Text="삭제" OnCommand="OnRespGridDelete"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="4%"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle CssClass="grid-row-alt" />
                        <FooterStyle CssClass="grid-row" />
                        <HeaderStyle CssClass="grid-head" />
                        <RowStyle CssClass="grid-row" />
                        <SelectedRowStyle CssClass="grid-row-select" />
                        <EditRowStyle CssClass="grid-row-select" />
                    </asp:GridView>
                </div>
                <div class="subnav">
                    <span class="title">응답파라메터</span>
                </div>
                <div class="content-grid">
                    <asp:GridView ID="gvRespParams" runat="server" Width="100%" AutoGenerateColumns="False" CssClass="grid"
                        OnRowDataBound="OnGridRowDataBound" OnRowCancelingEdit="OnGridRowCancelingEdit"
                        OnRowEditing="OnGridRowEditing" OnRowUpdating="OnGridRowUpdating">
                        <Columns>
                            <asp:TemplateField Visible="False">
                                <EditItemTemplate>
                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메터타입" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="droFieldType" runat="server" SelectedValue='<%# Bind("FieldTypeId") %>'
                                        Width="90%">
                                        <asp:ListItem Value="1">Int</asp:ListItem>
                                        <asp:ListItem Value="2">String</asp:ListItem>
                                        <asp:ListItem Value="3">Short</asp:ListItem>
                                        <asp:ListItem Value="4">Byte</asp:ListItem>
                                        <asp:ListItem Value="5">Record</asp:ListItem>
                                        <asp:ListItem Value="6">End</asp:ListItem>
                                        <asp:ListItem Value="7">Void</asp:ListItem>
                                        <asp:ListItem Value="8">Long</asp:ListItem>
                                        <asp:ListItem Value="9">Bool</asp:ListItem>
                                        <asp:ListItem Value="10">Float</asp:ListItem>
                                        <asp:ListItem Value="11">Double</asp:ListItem>
                                        <asp:ListItem Value="12">Date</asp:ListItem>
                                        <asp:ListItem Value="13">UInt</asp:ListItem>
                                        <asp:ListItem Value="14">UShort</asp:ListItem>
                                        <asp:ListItem Value="15">ULong</asp:ListItem>
                                        <asp:ListItem Value="16">SigleRecord</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabFieldType" runat="server" Text='<%# Bind("FieldTypeId") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("DepthTypeDescp") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="5%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메터명" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtField" runat="server" Text='<%# Bind("Field") %>' Width="90%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabField" runat="server" Text='<%# Bind("Field") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="10%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="파라메터설명" ItemStyle-Width="11%" ItemStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="hiDescption" runat="server" Text='<%# Bind("Descption") %>' Width="90%" Visible="False"></asp:TextBox>
                                    <asp:TextBox ID="txtDescption" runat="server" Text='<%# Bind("Remark") %>' Width="90%" TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabDescption" runat="server" Text='<%# Bind("Descption") %>'></asp:Label>
                                    <asp:Label ID="labRemark" runat="server" Text='<%# Bind("Remark") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="16%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="정렬" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <asp:Label ID="txtSortID" runat="server" Text='<%# Bind("SortID") %>' Width="90%"></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSortAsc" runat="server" CausesValidation="False" CommandArgument='<%#Eval("id")+","+Eval("ParamType")+","+Eval("SortID")%>'
                                        Text="↑오름차순" OnCommand="btnSortAsc_Command"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="btnSortDes" runat="server" CausesValidation="False" CommandArgument='<%#Eval("id")+","+Eval("ParamType")+","+Eval("SortID")%>'
                                        Text="↓내림차순" OnCommand="btnSortDes_Command"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="btnRecordSortAsc" runat="server" CausesValidation="False" CommandArgument='<%#Eval("id")+","+Eval("FieldTypeId")+","+Eval("SortID")%>'
                                        Text="↑순환" OnCommand="btnRecordSortAsc_Command"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="btnRecordSortDes" runat="server" CausesValidation="False" CommandArgument='<%#Eval("id")+","+Eval("FieldTypeId")+","+Eval("SortID")%>'
                                        Text="↓순환" OnCommand="btnRecordSortDes_Command"></asp:LinkButton>&nbsp;
                                </ItemTemplate>
                                <ItemStyle Width="10%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" ItemStyle-Width="4%" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" Width="4%"></ItemStyle>
                            </asp:CommandField>
                            <asp:TemplateField ShowHeader="False" HeaderText="조작" ItemStyle-Width="4%" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" OnClientClick="return confirm('정말삭제')"
                                        CommandArgument='<%#Eval("id")%>' Text="삭제" OnCommand="OnRespGridDelete"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="4%"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle CssClass="grid-row-alt" />
                        <FooterStyle CssClass="grid-row" />
                        <HeaderStyle CssClass="grid-head" />
                        <RowStyle CssClass="grid-row" />
                        <SelectedRowStyle CssClass="grid-row-select" />
                        <EditRowStyle CssClass="grid-row-select" />
                    </asp:GridView>
                </div>
                <div class="bottombar">
                    <% if (IsEdit){ %>
                    <span>
                        <asp:Button runat="server" ID="btnNoCompalte" OnClick="OnNoCompaltedClick" Text="미완성" /></span>
                    <span>
                        <asp:Button runat="server" ID="btnCompalte" OnClick="OnCompaltedClick" Text="완성" /></span>
                    <% } %>
                    <span>
                        <asp:CheckBox runat="server" ID="ckSelfAction"  Text="커스텀프로토콜" AutoPostBack="True" OnCheckedChanged="OnSelfActionChanged"/></span>
                </div>
            </div>
            <div class="fx-space"></div>
            <div class="right">
                <div id="navbox">
                    <ul id="tab_nav">
                        <li><a href="#tab_1">서버코드</a></li>
                        <li><a href="#tab_2">클라코드</a></li>
                        <li><a href="#tab_3">ENUM파람</a></li>
                        <li><a href="#tab_4">패킷디버깅</a></li>
                        <%--<li><a href="#tab_5">프로토콜설정</a></li>--%>
                    </ul>
                    <div id="tab_content">
                        <div id="tab_1" class="tab_item">
                            <div class="toolbar">
                                <span style="padding-left: 5px;">스크립트타입:</span>
                                <asp:DropDownList ID="ddServerCodeType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OnServerCodeTypeChanged">
                                    <asp:ListItem Value="C#"></asp:ListItem>
                                    <asp:ListItem Value="Python"></asp:ListItem>
                                    <asp:ListItem Value="Lua"></asp:ListItem>
                                </asp:DropDownList>
                                <span>&nbsp;</span>
                                <asp:Button id="btnExportServer" runat="server" Text="익스포트파일" OnClick="OnExportSererCode"/>
                                <span>&nbsp;</span>
                                <asp:Button id="btnExportAllServer" runat="server" Text="대량익스포트" OnClick="OnExportAllSererCode"/>
                                <span>&nbsp;</span>
                                <input type="button" id="btCopyServer" value="코드복사" onclick="onCopyCode('txtServerCode')"/>
                            </div>
                            <div style="width: 100%; height: 542px;">
                                <asp:TextBox ID="txtServerCode" runat="server" TextMode="MultiLine" CssClass="codeBox"></asp:TextBox>
                            </div>
                        </div>
                        <div id="tab_2" class="tab_item">
                            <div class="toolbar">
                                <span style="padding-left: 5px;">스크립트타입:</span>
                                <asp:DropDownList ID="ddClientCodeType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="OnClientCodeTypeChanged">
                                    <asp:ListItem Value="Lua">Cocos2d-x of Lua</asp:ListItem>
                                    <asp:ListItem Value="Quick">Quick</asp:ListItem>
                                    <asp:ListItem Value="C#">Unity3d of C#</asp:ListItem>
                                </asp:DropDownList>
                                <span>&nbsp;</span>
                                <asp:Button id="btnExportClient" runat="server" Text="익스포트파일" OnClick="OnExportClientCode"/>
                                <span>&nbsp;</span>
                                <asp:Button id="btnExportAllClient" runat="server" Text="대량익스포트" OnClick="OnExportAllClientCode"/>
                                <span>&nbsp;</span>
                                <input type="button" id="btCopyClient" value="코드복사" onclick="onCopyCode('txtServerCode')"/>
                            </div>
                            <div style="width: 100%; height: 542px;">
                                <asp:TextBox ID="txtClientCode" runat="server" TextMode="MultiLine" CssClass="codeBox"></asp:TextBox>
                            </div>
                        </div>
                        <div id="tab_3" class="tab_item">
                            <div style="width: 100%; height: 542px;">
                                <div id="lblEnumDescp" runat="server"></div>
                            </div>
                        </div>
                        <div id="tab_4" class="tab_item">
                            <iframe id="ifrTest" runat="server" style="width: 100%; height: 100%; border: 0;"></iframe>
                        </div>
                        <div id="tab_5" class="tab_item">
                            <iframe id="ifrClientConfig" runat="server" style="width: 100%; height: 100%; border: 0;"></iframe>
                        </div>
                    </div>
                </div>

            </div>
            <div class="botbar">
                <span>Copyright &copy; 2014 Scut, Inc.</span>
            </div>
        </div>
    </form>
</body>
</html>
