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
	
	/**
	 * 保存员工
	 * @param employee
	 */
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

	/**
	 * 根据id查找员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}
	
	/**
	 * 更新员工
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	/**
	 * 根据id删除单个员工
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	/**
	 * 批量删除员工
	 * @param id
	 */
	public void deleteBatch(List<Integer> id) {
		//创建根据id批量删除的条件
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(id);
		employeeMapper.deleteByExample(example);
	}
}
