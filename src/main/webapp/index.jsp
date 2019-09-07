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
	<!-- 修改员工模态框 -->
	<div class="modal fade" id="emp_update_modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"
									name="empName"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_update_input"
									name="email" placeholder="email"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交id即可 -->
								<select class="form-control" id="emp_update_select" name="dId">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

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
									name="empName" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_add_input"
									name="email" placeholder="email"> <span
									class="help-block"></span>
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
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp_table">
					<thead>
						<th><input type="checkbox" id="check_all"/></th>
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
		//总记录数，新增员工时会用到
		var totalPages;
		//当前页码，更新员工信息时会用到
		var currentPage;
		$(function() {
			//加载完成跳转到页码1
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				success : function(result) {
					//跳转之后清除全选框的数据
					$("#check_all").prop("checked",false);
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
			$
					.each(
							emps,
							function(index, emp) {
								var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
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
										.addClass("btn btn-primary editBtn")
										.append(
												($("<span></span>")
														.addClass("glyphicon glyphicon-pencil")))
										.append("编辑");
								var delBtn = $("<button></button>")
										.addClass("btn btn-danger deleteBtn")
										.append(
												($("<span></span>")
														.addClass("glyphicon glyphicon-trash")))
										.append("删除");
								var btnTd = $("<td></td>").append(editBtn).append(" ")
										.append(delBtn);
								//给编辑按钮的属性中加入员工id
								editBtn.attr("editId",emp.empId);
								//给删除按钮中的属性加入员工id
								delBtn.attr("delId",emp.empId);
								empTr = empTr.append(checkboxTd).append(empidTd).append(empNameTd)
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
			//把当前页码赋给全局变量，更新员工信息时会用到
			currentPage = pageInfo.pageNum;
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
		
		function formReset(ele) {
			//清楚表单中的数据
			$(ele)[0].reset();
			//重置样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，弹出一个模态框
		$("#emp_add_modal_btn").click(
				function() {
					//弹出模态框以后，重置表单数据和表单样式
					formReset("#emp_add_modal form");
					//点击按钮就发送一个ajax请求，查询全部部门信息
					getDepts("#emp_add_modal select");
					$("#emp_add_modal").modal({
						backdrop : "static"
					});
				});
		
		//点击编辑按钮，弹出模态框，对员工进行修改操作
		$(document).on("click",".editBtn",function() {
			//查出部门信息
			getDepts("#emp_update_modal select");
			//点击编辑按钮，需要对员工信息进行回显
			getEmp($(this).attr("editId"));
			//把员工id传给更新按钮
			$("#emp_update_btn").attr("empId",$(this).attr("editId"));
			$("#emp_update_modal").modal({
				backdrop:"static"
			});
		});
		
		//点击删除按钮，根据id删除单个员工
		$(document).on("click",".deleteBtn",function() {
			var empId = $(this).attr("delId");
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//发送确认框，是否删除员工
			if(confirm("是否删除["+empName+"]?")) {
				//确认删除后发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result) {
						alert(result.message);
						//回到当前页
						to_page(currentPage);
					}
				});
			}
		});
		//查询员工信息
		function getEmp(id){
			//发起ajax请求
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result) {
					//将查到的员工信息显示在模态框上
					var emp = result.extend.emp;
					$("#empName_update_static").text(emp.empName);
					$("#email_update_input").val(emp.email);
					$("#emp_update_modal input[name=gender]").val([emp.gender]);
					$("#emp_update_modal select").val([emp.dId]);
				}
			});
		}
		
		//查询部门信息
		function getDepts(ele){
			//对下拉框进行清空
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				success : function(result) {
					//对数据进行拼接，填充到select中
					$.each(result.extend.depts, function(index, dept) {
						var optionEle = $("<option></option>").append(
								dept.deptName).attr("value",
								dept.deptId);
						optionEle.appendTo($(ele));
					});
				}
			});
		}
		
		//用户输完用户名，发送ajax请求访问服务器，查询该用户名是否可用
		$("#empName_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
								url : "${APP_PATH}/checkUser",
								type : "POST",
								data : "empName=" + empName,
								success : function(result) {
									if (result.code == 100) {
										showValidateMsg("#empName_add_input",
												"success", "用户名可用");
										$("#emp_save_btn").attr("ajaxValidate",
												"success");
									} else {
										showValidateMsg("#empName_add_input",
												"fail", result.extend.validateMessage);
										$("#emp_save_btn").attr("ajaxValidate",
												"fail");
									}
								}
							});
				});

		//点击保存按钮，保存新增的员工，跳转到末页查看数据
		$("#emp_save_btn").click(function() {
			//发起请求前对输入进行校验
		 	if (!empAddValidate()) {
				return false;
			} 
			//发起请求之前还要确定ajax检验用户名的结果
			if ($("#emp_save_btn").attr("ajaxValidate") == "fail") {
				return false;
			}
			//发起ajax请求
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#emp_add_modal form").serialize(),
				success : function(result) {
					if(result.code == 100) {	
						//保存成功以后，1.关闭模态框
						$("#emp_add_modal").modal('hide');
						//跳转到末页，查看新添加的数据
						to_page(totalPages + 1);
					} else {
						if(result.extend.errorField.empName != undefined) {
							showValidateMsg("#empName_add_input","fail",result.extend.errorField.empName);
							return false;
						}
						if(result.extend.errorField.email != undefined) {
							showValidateMsg("#email_add_input","fail",result.extend.errorField.email);
							return false;
						}
					}
				}
			});
		});
		
		//点击更新按钮，对员工信息进行更新
		$("#emp_update_btn").click(function() {
			//对邮箱格式进行校验
			var email = $("#email_update_input").val();
			var regEmail = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/;
			if (!regEmail.test(email)) {
				showValidateMsg("#email_update_input", "fail", "邮箱格式错误");
				return false;
			} else {
				showValidateMsg("#email_update_input", "success", "");
			}
			//发送ajax请求更新员工
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("empId"),
				type:"PUT",
				data:$("#emp_update_modal form").serialize(),
				success:function(result){
					//修改成功以后关闭模态框，跳转到对应的页面
					$("#emp_update_modal").modal("hide");
					to_page(currentPage);
				}
			});
		});
		
		//校验用户输入信息
		function empAddValidate() {
			//用户名
			var empName = $("#empName_add_input").val();
			//用户名可以由6-16位由数字、大小写字母和中文-_组成
			var regEmpName = /^[0-9a-zA-Z-_\u2E80-\u9FFF]{4,16}$/;
			var email = $("#email_add_input").val();
			var regEmail = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/;
			//用户名校验
			if (!regEmpName.test(empName)) {
				showValidateMsg("#empName_add_input", "fail",
						"用户名可以由4-16位由数字、大小写字母和中文-_组成");
				return false;
			} else {
				showValidateMsg("#empName_add_input", "success", "");
			}
			if (!regEmail.test(email)) {
				showValidateMsg("#email_add_input", "fail", "邮箱格式错误");
				return false;
			} else {
				showValidateMsg("#email_add_input", "success", "");
			}
			return true;
		}

		//显示校验结果信息
		function showValidateMsg(ele, status, message) {
			//开始显示之前先清除
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if (status == "success") {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(message);
			} else if (status == "fail") {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(message);
			}
		}
		
		//给全选框添加点击事件
		$("#check_all").click(function() {
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//给单个的checkbox添加点击事件，从而使全选框和checkbox们保持相同的状态
		$(document).on("click",".check_item",function() {
			var flag = $(".check_item").length == $(".check_item:checked").length;
			if(flag) {
				$("#check_all").prop("checked",true);
			} else {
				$("#check_all").prop("checked",false);
			}
		});
		
		//给批量删除按钮添加点击事件
		$("#emp_delete_all_btn").click(function(){
			//获取当前被选中的员工的id和姓名
			var empIds = "";
			var empNames = "";
			$.each($(".check_item:checked"),function(){
				empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			});
			//删掉多余的符号
			empIds.substring(0,empIds.length-1);
			empNames.substring(0,empNames.length-1);
			if(confirm("确认要删除["+empNames+"]?")) {
				//确认删除发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+empIds,
					type:"DELETE",
					success:function(result) {
						alert(result.message);
						//删除以后跳转到本页
						to_page(currentPage);
					}
				})
			}
		});
		
</script>