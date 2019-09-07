package com.vi.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 检验用户名是否唯一
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(@RequestParam("empName")String empName){
		//先检验用户名格式是否正确
		String regx = "^[0-9a-zA-Z-_\u2E80-\u9FFF]{4,16}$";
		if(!empName.matches(regx)) {
			return Msg.fail().add("validateMessage", "用户名可以由6-16位由数字、大小写字母和中文-_组成");
		}
		boolean flag = employeeService.checkUser(empName);
		if(flag){
			return Msg.success();
		} else {
			return Msg.fail().add("validateMessage", "用户名不可用");
		}
	}
	
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
	
	/**
	 * 保存员工
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		//JSR303校验
		if(result.hasErrors()){
			List<FieldError> errors = result.getFieldErrors();
			Map<String,Object> map = new HashMap<String,Object>();
			for(FieldError fieldError : errors) {
				System.out.println("错误信息的字段名:"+fieldError.getField());
				System.out.println("错误信息:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		}
		employeeService.save(employee);
		return Msg.success();
	}
	
	/**
	 * 更新员工
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success().add("emp", employee.toString());
	}
	
	/**
	 * 根据id删除单个员工
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("id") Integer id) {
		employeeService.deleteEmp(id);
		return Msg.success();
	}
}
