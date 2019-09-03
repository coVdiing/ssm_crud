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
				<table class="table table-hover" id="emp_table">
					<thead>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>do</th>
					</thead>
					
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-4" id="page_info_area">
			</div>
				
			<!-- 导航信息 -->
			<div class="col-md-8 " id="page_info_nav">
			
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(function(){
		//加载完成跳转到页码1
		to_page(1);
	});
	
	function to_page(pn) {
		$.ajax({	
			url:"http://localhost:8080/ssm_crud_copy/emps",
			data:"pn="+pn,
			success:function(result) {
				build_empTable(result);
				build_pageInfo(result);
				build_pageNav(result);
			}
		});
	}
	
	//添加数据到表格
	function build_empTable(result) {
		$("#emp_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		$.each( emps,function(index,emp){
			var empTr = $("<tr></tr>");
			var empidTd = $("<td></td>").append(emp.empId);
			var empNameTd = $("<td></td>").append(emp.empName);
			var genderTd = $("<td></td>").append(emp.gender=="M"?"男":"女");
			var emailTd = $("<td></td>").append(emp.email);
			var deptNameTd = $("<td></td>").append(emp.department.deptName);
			var editBtn = $("<button></button>").addClass("btn btn-primary").append(($("<span></span>").addClass("glyphicon glyphicon-pencil"))).append("编辑");
			var delBtn = $("<button></button>").addClass("btn btn-danger").append(($("<span></span>").addClass("glyphicon glyphicon-trash"))).append("删除");
			var btnTd = $("<td></td>").append(editBtn).append(delBtn);
			empTr = empTr.append(empidTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd);
			$("#emp_table tbody").append(empTr); 
			}
		);
	}
	
	//分页信息
	function build_pageInfo(result) {
		$("#page_info_area").empty();
		var pageInfo = result.extend.pageInfo;
		var pageInfoArea = $("#page_info_area").append("当前第"+pageInfo.pageNum+"页,共"+pageInfo.pages+"页，共"+pageInfo.total+"条数据");
	}
	
	//页码信息
	function build_pageNav(result) {
		$("#page_info_nav").empty();
		var pageInfo = result.extend.pageInfo;
		var nav = $("<nav></nav>");
		var ul = $("<ul></ul>").addClass("pagination");
		//首页
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		//上一页
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		//下一页
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		//末页
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(pageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		} else {
			//绑定点击事件
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(pageInfo.pageNum-1);
			});
		}
		if(pageInfo.hasNextPage == false) {
			lastPageLi.addClass("disabled");
			nextPageLi.addClass("disabled");
		} else {
			lastPageLi.click(function(){
				to_page(pageInfo.pages);
			});
			nextPageLi.click(function() {
				to_page(pageInfo.pageNum+1);
			});
		}
		
		
		ul.append(ul).append(firstPageLi).append(prePageLi);
		//中间的页码
		$.each(pageInfo.navigatepageNums,function(index,item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			//给页码绑定点击事件
			numLi.click(function(){
				to_page(item);
			});
			ul.append(numLi);
		});
		ul.append(nextPageLi).append(lastPageLi);
		$("#page_info_nav").append(nav).append(ul);
	}
	</script>
</body>
</html>