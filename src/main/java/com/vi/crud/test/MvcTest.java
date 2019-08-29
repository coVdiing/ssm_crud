package com.vi.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.vi.crud.bean.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:spring-mvc.xml" })
public class MvcTest {
	// 引入Spring mvc的ioc容器
	@Autowired
	WebApplicationContext context;

	// 虚拟mvc请求，获取到处理结果
	MockMvc mockMvc;

	@Before
	public void initMock() {
		 mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "7")).andReturn();
		//取出pageInfo
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi =(PageInfo)request.getAttribute("pageInfo");
		//取出查询到的数据
		System.out.println("当前页:"+pi.getPageNum());
		System.out.println("结果总数:"+pi.getTotal());
		System.out.println("每页的记录数"+pi.getPageSize());
		System.out.println("总页码:"+pi.getPages());
		System.out.println("页面连续显示的页码:");
		int[] nums = pi.getNavigatepageNums();
		for(int i : nums) {
			System.out.println(i + " ");
		}
		System.out.println("\n员工信息:");
		List<Employee> emps = pi.getList();
		for(Employee emp : emps)
			System.out.println("ID:"+emp.getEmpId()+"==>Name："+emp.getEmpName());
	}
}
