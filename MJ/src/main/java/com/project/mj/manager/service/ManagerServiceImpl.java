package com.project.mj.manager.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.mj.manager.dao.ManagerDAO;
import com.project.mj.manager.domain.BoardVO;
import com.project.mj.manager.domain.ConfirmVO;
import com.project.mj.manager.domain.CustomerVO;
import com.project.mj.manager.domain.DailyLogVO;
import com.project.mj.manager.domain.FcVO;
import com.project.mj.manager.domain.ManagerVO;
import com.project.mj.manager.domain.MemoVO;
import com.project.mj.manager.domain.SearchVO;
import com.project.mj.manager.domain.StatusVO;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Inject
	private ManagerDAO dao;

	@Override
	public ManagerVO managerLogin(ManagerVO managerVO) throws Exception {
		return dao.userLogin(managerVO);
	}

	@Override
	public List<CustomerVO> getCustomerList(SearchVO search) {
		return dao.getCustomerList(search);
	}

	@Override
	public int customerCnt(SearchVO search) {
		return dao.customerCnt(search);
	}

	@Override
	public void deleteCustomer(int id) {
		dao.deleteCustomer(id);
		
	}

	@Override
	public List<StatusVO> getStatusList() {
		return dao.getStatusList();
	}

	@Override
	public CustomerVO getCustomerInfo(int id) {
		return dao.getCustomerInfo(id);
	}

	@Override
	public List<ManagerVO> getManagerList(SearchVO search) {
		return dao.getManagerList(search);
	}

	@Override
	public int managerCnt(SearchVO search) {
		return dao.managerCnt(search);
	}

	@Override
	public int updateCustomer(CustomerVO customer) {
		return dao.updateCustomer(customer);
	}

	@Override
	public void deleteManager(String id) {
		dao.deleteManager(id);
	}

	@Override
	public ManagerVO getManagerInfo(String id) {
		return dao.getManagerInfo(id);
	}

	@Override
	public int updateManager(ManagerVO manager) {
		return dao.updateManager(manager);
	}

	@Override
	public int insertCustomer(CustomerVO customer) {
		return dao.insertCustomer(customer);
	}

	@Override
	public int insertManager(ManagerVO manager) {
		return dao.insertManager(manager);
	}

	@Override
	public List<FcVO> getFcList() {
		return dao.getFcList();
	}

	@Override
	public List<ConfirmVO> getConfirmIpList() {
		return dao.getConfirmIpList();
	}

	@Override
	public int insertFc(FcVO fc) {
		return dao.insertFc(fc);
	}

	@Override
	public int insertConfirmIp(ConfirmVO ip) {
		return dao.insertIP(ip);
	}

	@Override
	public int insertDailyLog(DailyLogVO log) {
		return dao.insertDailyLog(log);
	}

	@Override
	public List<DailyLogVO> getDailyLogList(SearchVO search) {
		return dao.getDailyLogList(search);
	}

	@Override
	public int dailyLogCnt(SearchVO search) {
		return dao.dailyLogCnt(search);
	}

	@Override
	public int deleteFc(int id) {
		// TODO Auto-generated method stub
		return dao.deleteFc(id);
	}
	
	@Override
	public int deleteIp(int id) {
		return dao.deleteIp(id);
	}
	
	@Override
	public int deleteStatus(int id) {
		return dao.deleteStatus(id);
	}

	@Override
	public int insertStatus(StatusVO status) {
		return dao.insertStatus(status);
	}

	@Override
	public int deleteLog(int id) {
		return dao.deleteLog(id);
	}

	@Override
	public DailyLogVO getDailyLog(int id) {
		return dao.getDailyLogList(id);
	}

	@Override
	public int updateDailyLog(DailyLogVO log) {
		return dao.updateDailyLog(log);
	}

	@Override
	public List<DailyLogVO> getGraphList(SearchVO search) {
		return dao.getGraphList(search);
	}

	@Override
	public int statusChange(DailyLogVO vo) {
		return dao.updateStatus(vo);
	}

	@Override
	public List<CustomerVO> getCustomerAll() {
		return dao.getCustomerAll();
	}

	@Override
	public int changeStatus(CustomerVO vo) {
		return dao.changeStatus(vo);
	}

	@Override
	public int changeManager(CustomerVO vo) {
		return dao.changeManager(vo);
	}

	@Override
	public List<BoardVO> getBoardList(SearchVO search) {
		return dao.getBoardList(search);
	}

	@Override
	public int boardCnt(SearchVO search) {
		return dao.getBoardCnt(search);
	}

	@Override
	public int insertBoard(BoardVO board) {
		return dao.insertBoard(board);
	}

	@Override
	public BoardVO getBoard(int id) {
		return dao.getBoard(id);
	}

	@Override
	public int updateBoard(BoardVO board) {
		return dao.updateBoard(board);
	}

	@Override
	public int deleteBoard(int id) {
		return dao.deleteBoard(id);
	}

	@Override
	public int customerDupCheck(CustomerVO customer) {
		return dao.customerDupCheck(customer);
	}

	@Override
	public int getCustomerId(CustomerVO customer) {
		return dao.getCustomerId(customer);
	}

	@Override
	public void insertMemo(CustomerVO customer) {
		dao.insertMemo(customer);
	}

	@Override
	public List<MemoVO> getMemoList(int id) {
		return dao.getMemoList(id);
	}

	@Override
	public void deleteMemo(int id) {
		dao.deleteMemo(id);
	}

}
