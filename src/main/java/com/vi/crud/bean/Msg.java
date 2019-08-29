package com.vi.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	// 状态码，规定100-成功，200-失败
	private int code;
	// 提示信息
	private String message;
	// 接收数据
	private Map<String, Object> extend = new HashMap<String, Object>();

	// 返回处理成功时的数据
	public Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMessage("处理成功");
		return msg;
	}
	
	//返回处理失败时的数据
	public Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMessage("处理失败");
		return msg;
	}
	
	//添加数据到extend中
	public Msg add(String key,Object value) {
		this.extend.put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}
