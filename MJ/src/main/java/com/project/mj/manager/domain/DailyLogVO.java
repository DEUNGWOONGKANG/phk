package com.project.mj.manager.domain;

import java.util.Date;

public class DailyLogVO {
	private int id;
	private String referee;
	private String name;
	private int customerId ;
	private String fc;
	private int money;
	private int dmoney;
	private int totalmoney;
	private int totaldmoney;
	private int diffmoney;
	private String dbDate;
	private String depositDate;
	private String manager;
	private int status;
	private Date created;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getReferee() {
		return referee;
	}
	public void setReferee(String referee) {
		this.referee = referee;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFc() {
		return fc;
	}
	public void setFc(String fc) {
		this.fc = fc;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getDmoney() {
		return dmoney;
	}
	public void setDmoney(int dmoney) {
		this.dmoney = dmoney;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getDbDate() {
		return dbDate;
	}
	public void setDbDate(String dbDate) {
		this.dbDate = dbDate;
	}
	public String getDepositDate() {
		return depositDate;
	}
	public void setDepositDate(String depositDate) {
		this.depositDate = depositDate;
	}
	public int getDiffmoney() {
		return diffmoney;
	}
	public void setDiffmoney(int diffmoney) {
		this.diffmoney = diffmoney;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(int totalmoney) {
		this.totalmoney = totalmoney;
	}
	public int getTotaldmoney() {
		return totaldmoney;
	}
	public void setTotaldmoney(int totaldmoney) {
		this.totaldmoney = totaldmoney;
	}
	
}
