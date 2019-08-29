<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String APP_PATH = request.getContextPath();
	request.setAttribute("APP_PATH", APP_PATH);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<!-- 引入样式 -->
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD-改</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>do</th>
					</thead>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<td>${emp.empId}</td>
							<td>${emp.empName }/td>
							<td>${emp.gender }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary">
									<span class="glyphicon glyphicon-pencil">编辑</span>
								</button>
								<button class="btn btn-danger">
									<span class="glyphicon glyphicon-trash">删除</span>
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-4">
				第${pageInfo.pageNum}页，共${pageInfo.pages}页，共${pageInfo.total}条记录</div>
			<!-- 导航信息 -->
			<div class="col-md-8 ">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageInfo.navigatepageNums}" var="num" begin="0"
						end="4">
						<c:if test="${num == pageInfo.pageNum}">
							<li class="active"><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
						</c:if>
						<c:if test="${num != pageInfo.pageNum}">
							<li><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${pageInfo.hasNextPage }">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>

					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>