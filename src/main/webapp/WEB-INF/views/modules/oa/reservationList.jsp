<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预约管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/reservation/">预约列表</a></li>
		<shiro:hasPermission name="oa:reservation:edit"><li><a href="${ctx}/oa/reservation/form">预约添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="reservation" action="${ctx}/oa/reservation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户：</label>
				<form:input path="customerName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>医生：</label>
				<form:input path="doctorName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<!-- 
			<li><label>预约时间：</label>
				<input name="reservationTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${reservation.reservationTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			 -->
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>客户</th>
				<th>医生</th>
				<th>预约时间</th>
				<th>预约项目</th>
				<th>状态</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="oa:reservation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="reservation">
			<tr>
				<td><a href="${ctx}/oa/reservation/form?id=${reservation.id}">
					${reservation.customerName}
				</a></td>
				<td>
					${reservation.doctorName}
				</td>
				<td>
					<fmt:formatDate value="${reservation.reservationTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${reservation.projectName}
				</td>
				<td>
					${fns:getDictLabel(reservation.status, 'remedy_flag', '')}
				</td>
				<td>
					<fmt:formatDate value="${reservation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${reservation.remarks}
				</td>
				<shiro:hasPermission name="oa:reservation:edit"><td>
    				<a href="${ctx}/oa/reservation/form?id=${reservation.id}">修改</a>
					<a href="${ctx}/oa/reservation/delete?id=${reservation.id}" onclick="return confirmx('确认要删除该预约吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>