package com.project.mj.manager.domain;

import java.util.Date;

public class CustomerVO {
	private int id;
	private String name;
	private String reg_num1;
	private String reg_num2;
	private String job;
	private String tel1;
	private String tel2;
	private String tel3;
	private String receive;
	private String memo;
	private String status;
	private String manager;
	private Date created;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReg_num1() {
		return reg_num1;
	}
	public void setReg_num1(String reg_num1) {
		this.reg_num1 = reg_num1;
	}
	public String getReg_num2() {
		return reg_num2;
	}
	public void setReg_num2(String reg_num2) {
		this.reg_num2 = reg_num2;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getReceive() {
		return receive;
	}
	public void setReceive(String receive) {
		this.receive = receive;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
