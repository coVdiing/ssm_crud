package com.vi.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vi.crud.bean.Employee;
import com.vi.crud.bean.Msg;
import com.vi.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//跟在这个方法后的查询会被分页
		PageHelper.startPage(pn,5);
		//这是一个未分页的查询，需要引入分页插件
		List<Employee> emps = employeeService.getAll();
		//经过视图解析器处理，会加上前缀/WEB-INF/views/和后缀.jsp
		//把查询出的结果封装到PageInfo中
		PageInfo pageInfo = new PageInfo(emps);
		Msg result = new Msg();
		return result.add("pageInfo", pageInfo);
	}
}
