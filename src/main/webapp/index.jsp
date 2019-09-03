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
	<!-- 添加员工模态框 -->
	<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add_input"
									name="empName" placeholder="empName">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_add_input"
									name="email" placeholder="email">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交id即可 -->
								<select class="form-control" name="dId">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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
			<div class="col-md-4" id="page_info_area"></div>

			<!-- 导航信息 -->
			<div class="col-md-8 " id="page_info_nav"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalPages;
		$(function() {
			//加载完成跳转到页码1
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				success : function(result) {
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
			$.each(	emps,function(index, emp) {
								var empTr = $("<tr></tr>");
								var empidTd = $("<td></td>").append(emp.empId);
								var empNameTd = $("<td></td>").append(
										emp.empName);
								var genderTd = $("<td></td>").append(
										emp.gender == "M" ? "男" : "女");
								var emailTd = $("<td></td>").append(emp.email);
								var deptNameTd = $("<td></td>").append(
										emp.department.deptName);
								var editBtn = $("<button></button>")
										.addClass("btn btn-primary")
										.append(
												($("<span></span>")
														.addClass("glyphicon glyphicon-pencil")))
										.append("编辑");
								var delBtn = $("<button></button>")
										.addClass("btn btn-danger")
										.append(
												($("<span></span>")
														.addClass("glyphicon glyphicon-trash")))
										.append("删除");
								var btnTd = $("<td></td>").append(editBtn)
										.append(delBtn);
								empTr = empTr.append(empidTd).append(empNameTd)
										.append(genderTd).append(emailTd)
										.append(deptNameTd).append(btnTd);
								$("#emp_table tbody").append(empTr);
							});
		}

		//分页信息
		function build_pageInfo(result) {
			$("#page_info_area").empty();
			var pageInfo = result.extend.pageInfo;
			totalPages = pageInfo.pages;
			var pageInfoArea = $("#page_info_area").append(
					"当前第" + pageInfo.pageNum + "页,共" + pageInfo.pages + "页，共"
							+ pageInfo.total + "条数据");
		}

		//页码信息
		function build_pageNav(result) {
			$("#page_info_nav").empty();
			var pageInfo = result.extend.pageInfo;
			var nav = $("<nav></nav>");
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			//上一页
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			//下一页
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			//末页
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//绑定点击事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(pageInfo.pageNum - 1);
				});
			}
			if (pageInfo.hasNextPage == false) {
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
			} else {
				lastPageLi.click(function() {
					to_page(pageInfo.pages);
				});
				nextPageLi.click(function() {
					to_page(pageInfo.pageNum + 1);
				});
			}

			ul.append(ul).append(firstPageLi).append(prePageLi);
			//中间的页码
			$.each(pageInfo.navigatepageNums, function(index, item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				//给页码绑定点击事件
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			$("#page_info_nav").append(nav).append(ul);
		}
		
		//点击按钮，弹出一个模态框
 		$("#emp_add_modal_btn").click(function() {
 			//点击按钮就发送一个ajax请求，查询全部部门信息
			$.ajax({
				url:"${APP_PATH}/depts",
				success:function(result) {
					//对数据进行拼接，填充到select中
					var select = $("#emp_add_modal select");
					//对下拉框进行清空
					select.empty();
					$.each(result.extend.depts,function(index,dept) {
						select.append($("<option></option>").append(dept.deptName).attr("value",dept.deptId));
					});
				}
			});
			$("#emp_add_modal").modal({
				backdrop : "static"
			});
		}); 
		
		//点击保存按钮，保存新增的员工，跳转到末页查看数据
		$("#emp_save_btn").click(function(){
			//发起ajax请求
 			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#emp_add_modal form").serialize(),
				success:function(result) {
					//保存成功以后，1.关闭模态框
					$("#emp_add_modal").modal('hide');
					//跳转到末页，查看新添加的数据
					to_page(totalPages+1);
				}
			});
		}); 
		
	</script>
</body>
</html>