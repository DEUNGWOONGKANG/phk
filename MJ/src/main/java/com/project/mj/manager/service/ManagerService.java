package com.project.mj.manager.service;

import java.util.List;

import org.springframework.stereotype.Service;

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
public interface ManagerService {
	
	public ManagerVO managerLogin(ManagerVO managerVO) throws Exception;

	public List<CustomerVO> getCustomerList(SearchVO search);
	
	public int customerCnt(SearchVO search);

	public void deleteCustomer(int id);

	public List<StatusVO> getStatusList();

	public CustomerVO getCustomerInfo(int id);

	public List<ManagerVO> getManagerList(SearchVO search);

	public int managerCnt(SearchVO search);

	public int updateCustomer(CustomerVO customer);

	public void deleteManager(String id);

	public ManagerVO getManagerInfo(String id);

	public int updateManager(ManagerVO manager);

	public int insertCustomer(CustomerVO customer);

	public int insertManager(ManagerVO manager);

	public List<FcVO> getFcList();

	public List<ConfirmVO> getConfirmIpList();

	public int insertFc(FcVO fc);

	public int insertConfirmIp(ConfirmVO ip);

	public int insertDailyLog(DailyLogVO log);

	public List<DailyLogVO> getDailyLogList(SearchVO search);

	public int dailyLogCnt(SearchVO search);

	public int deleteFc(int id);
	
	public int deleteIp(int id);

	public int insertStatus(StatusVO status);

	public int deleteStatus(int id);

	public int deleteLog(int id);

	public DailyLogVO getDailyLog(int id);

	public int updateDailyLog(DailyLogVO log);

	public List<DailyLogVO> getGraphList(SearchVO search);

	public int statusChange(DailyLogVO vo);

	public List<CustomerVO> getCustomerAll();

	public int changeStatus(CustomerVO vo);

	public int changeManager(CustomerVO vo);

	public List<BoardVO> getBoardList(SearchVO search);

	public int boardCnt(SearchVO search);

	public int insertBoard(BoardVO board);

	public BoardVO getBoard(int id);

	public int updateBoard(BoardVO board);

	public int deleteBoard(int id);

	public int customerDupCheck(CustomerVO customer);

	public int getCustomerId(CustomerVO customer);

	public void insertMemo(CustomerVO customer);

	public List<MemoVO> getMemoList(int id);

	public void deleteMemo(int id);
}
