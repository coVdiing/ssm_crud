package com.vi.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.vi.crud.bean.Employee;
import com.vi.crud.dao.DepartmentMapper;
import com.vi.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCrud() {
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@vi.com", 8));
		//批量增加employee
		EmployeeMapper em = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0 ; i < 100 ; i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			em.insertSelective(new Employee(null, uid, "M", uid+"@vi.com", 8));
		}
	}
	
	public static void main(String[] args) {
		
	
	}
}
