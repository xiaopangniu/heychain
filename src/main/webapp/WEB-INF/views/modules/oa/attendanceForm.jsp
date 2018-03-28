<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>就诊信息管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/common/dateoperation.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			if(!getQueryString('id')){
				$("#attendanceTime").val(getCurrentDateTime(null));
				$('input[name=attendanceType]').get(0).checked = true;
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/attendance/">就诊信息列表</a></li>
		<li class="active"><a href="${ctx}/oa/attendance/form?id=${attendance.id}">就诊信息<shiro:hasPermission name="oa:attendance:edit">${not empty attendance.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oa:attendance:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="attendance" action="${ctx}/oa/attendance/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">客户：</label>
			<div class="controls">
				<form:hidden path="customerId" />
				<form:input path="customerName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">就诊时间：</label>
			<div class="controls">
				<input id="attendanceTime" name="attendanceTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${attendance.attendanceTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">就诊类型：</label>
			<div class="controls">
				<form:radiobuttons path="attendanceType" items="${fns:getDictList('attendance_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预约编号：</label>
			<div class="controls">
				<input id="reservationId" name="reservationId" type="hidden" />
				<form:input path="reservationNumber" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="oa:attendance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>