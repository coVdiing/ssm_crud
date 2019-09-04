package com.vi.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vi.crud.bean.Employee;
import com.vi.crud.bean.EmployeeExample;
import com.vi.crud.bean.EmployeeExample.Criteria;
import com.vi.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	public void save(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	/**
	 * 校验用户名是否可用
	 * @param empName
	 * @return 返回true表示可用，false不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
}
