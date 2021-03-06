<%@ page contentType="text/html;charset=UTF-8" language="java"
	errorPage="../common/error.jsp"%>
<%@include file="../common/common.jsp"%>
<html>
<head>
<p:link title="增加退货快递信息" />
<script language="JavaScript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/cnchina.js"></script>
<script language="JavaScript" src="../js/public.js"></script>
<script language="JavaScript" src="../js/JCheck.js"></script>
<script language="JavaScript" src="../js/json.js"></script>
<script language="JavaScript" src="../js/prototype.js"></script>
<script language="JavaScript" src="../js/buffalo.js"></script>
<script language="javascript">
var END_POINT="${pageContext.request.contextPath}/bfapp";

var buffalo = new Buffalo(END_POINT);

var cmap = window.top.topFrame.cmap;

var pList = window.top.topFrame.pList;

function addBean()
{
	submit('确定增加退货快递信息?', null, null);
}

function changes(obj)
{
    removeAllItem($O('fromCity'));
    setOption($O('fromCity'), "", "--");
    if ($$('fromProvince') == "")
    {
        return;
    }
    
    var cityList = cmap[$$('fromProvince')];
    for (var i = 0; i < cityList.length; i++)
    {
        setOption($O('fromCity'), cityList[i].id, cityList[i].name);
    }
}

function changes2(obj)
{
    removeAllItem($O('toCity'));
    setOption($O('toCity'), "", "--");
    if ($$('toProvince') == "")
    {
        return;
    }
    
    var cityList = cmap[$$('toProvince')];
    for (var i = 0; i < cityList.length; i++)
    {
        setOption($O('toCity'), cityList[i].id, cityList[i].name);
    }
}

function load()
{
    setOption($O('fromProvince'), "", "--");
    for (var i = 0; i < pList.length; i++)
    {
        setOption($O('fromProvince'), pList[i].id, pList[i].name);
    }
    
    setOption($O('toProvince'), "", "--");
    for (var i = 0; i < pList.length; i++)
    {
        setOption($O('toProvince'), pList[i].id, pList[i].name);
    }
    
    loadForm();
}

function selectStaffer()
{
    window.common.modal('../admin/pop.do?method=rptQueryStaffer&load=1&selectMode=1');
}

function getStaffers(oos)
{
    var oo = oos[0];
    
    $O('receiver').value = oo.pname;
    $O('receiverId').value = oo.value;
}

</script>

</head>
<body class="body_class" onload="load()">
<form name="formEntry" action="../sail/outback.do" method="post">
<input type="hidden" name="method" value="addOutBack">
<input type="hidden" name="receiverId" value="">
<input type="hidden" name="id" value="${bean.id}">

<p:navigation
	height="22">
	<td width="550" class="navigation"><span style="cursor: pointer;"
		onclick="javascript:history.go(-1)">退货管理</span> &gt;&gt; 增加退货快递信息</td>
	<td width="85"></td>
	
</p:navigation> <br>

<p:body width="98%">

	<p:title>
		<td class="caption"><strong>基本信息：</strong></td>
	</p:title>

	<p:line flag="0" />

	<p:subBody width="100%">
		<p:class value="com.china.center.oa.sail.bean.OutBackBean" opr="2"/>
		<p:table cells="2">
		    
		    <p:pro field="expressCompany">
               <option value="">--</option>
               <c:forEach items="${transportList}" var="item">
                   <option value="${item.id}">${item.name}</option>
               </c:forEach>
            </p:pro>
            
            <p:pro field="transportNo" />

			<p:pro field="fromProvince"
				innerString="quick=true onchange=changes(this)" />
				
			<p:cell title="发货城市">${bean.fromCityName}</p:cell>
			
			<p:pro field="fromAddress" innerString="size=120" cell="0"/>
			
			<p:pro field="fromer" />
			
			<p:pro field="fromMobile" />
            
            <p:pro field="toProvince"
				innerString="quick=true onchange=changes2(this)" />
			<p:cell title="收货城市">${bean.toCityName}</p:cell>
            
            <p:pro field="toAddress" innerString="size=120" cell="0"/>
            
            <p:pro field="to" />
            
            <p:pro field="toMobile" />

			<p:pro field="receiver" />
			
			<p:pro field="receiverDate" />
			
			<p:pro field="goods" innerString="oncheck='isMathNumber'" cell="0"/>					
            
            <p:pro field="claimer" />
            <p:pro field="claimTime" />
            
            <p:pro field="checker" />
            <p:pro field="checkTime" />
            <p:pro field="checkReason" cell="0"/>

            <p:pro field="handoverChecker" />
            <p:pro field="handoverCheckTime" />
            <p:pro field="handoverReason" cell="0"/>

            <p:pro field="confirmChecker" />
            <p:pro field="confirmCheckTime" />
            <p:pro field="note" cell="0"/>
            
			<p:pro field="description" cell="0" innerString="rows=3 cols=55" />
			
			<p:cell title="附件" width="8" end="true">
            <c:forEach items="${bean.attachmentList}" var="item">
            <a href="../sail/outback.do?method=downAttachmentFile&id=${item.id}" title="点击下载附件">${item.name}</a>
            <br>
            <br>
            </c:forEach>
            </p:cell>

		</p:table>
	</p:subBody>

	<p:line flag="1" />

    <p:subBody width="100%">
        <table width="100%" border="0" cellspacing='1' id="tables">
            <tr align="center" class="content0">
                <td width="10%" align="center">审批人</td>
                <td width="10%" align="center">审批动作</td>
                <td width="10%" align="center">前状态</td>
                <td width="10%" align="center">后状态</td>
                <td width="45%" align="center">意见</td>
                <td width="15%" align="center">时间</td>
            </tr>

            <c:forEach items="${logList}" var="item" varStatus="vs">
                <tr class='${vs.index % 2 == 0 ? "content1" : "content2"}'>
                    <td align="center">${item.actor}</td>

                    <td align="center">${my:get('oprMode', item.oprMode)}</td>

                    <td align="center">${my:get('outbackStatus', item.preStatus)}</td>

                    <td align="center">${my:get('outbackStatus', item.afterStatus)}</td>

                    <td align="center">${item.description}</td>

                    <td align="center">${item.logTime}</td>

                </tr>
            </c:forEach>
        </table>
    </p:subBody>

    <p:line flag="2" />

	<p:button leftWidth="100%" rightWidth="0%">
		<div align="right"><input type="button" class="button_class" id="ok_b"
			style="cursor: pointer" value="&nbsp;&nbsp;返 回&nbsp;&nbsp;"
			onclick="javaScript:window.history.go(-1);"></div>
	</p:button>

	<p:message2/>
</p:body></form>
</body>
</html>

