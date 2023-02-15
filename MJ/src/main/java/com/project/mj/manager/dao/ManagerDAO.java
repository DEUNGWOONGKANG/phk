package com.project.mj.manager.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.mj.manager.domain.BoardVO;
import com.project.mj.manager.domain.ConfirmVO;
import com.project.mj.manager.domain.CustomerVO;
import com.project.mj.manager.domain.DailyLogVO;
import com.project.mj.manager.domain.FcVO;
import com.project.mj.manager.domain.ManagerVO;
import com.project.mj.manager.domain.MemoVO;
import com.project.mj.manager.domain.SearchVO;
import com.project.mj.manager.domain.StatusVO;

@Repository
public class ManagerDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static String namespace = "ManagerMapper";
	 
	public ManagerVO userLogin(ManagerVO managerVO) throws Exception {
		return sqlSession.selectOne(namespace+".managerLogin", managerVO);
	}

	public List<CustomerVO> getCustomerList(SearchVO search) {
		return sqlSession.selectList(namespace+".getCustomerList", search);
	}

	public int customerCnt(SearchVO search) {
		return sqlSession.selectOne(namespace+".customerCnt", search);
	}

	public void deleteCustomer(int id) {
		sqlSession.delete(namespace+".deleteCustomer", id);
	}

	public List<StatusVO> getStatusList() {
		return sqlSession.selectList(namespace+".getStatusList");
	}

	public CustomerVO getCustomerInfo(int id) {
		return sqlSession.selectOne(namespace+".getCustomerInfo", id);
	}

	public List<ManagerVO> getManagerList(SearchVO search) {
		return sqlSession.selectList(namespace+".getManagerList", search);
	}

	public int managerCnt(SearchVO search) {
		return sqlSession.selectOne(namespace+".managerCnt", search);
	}

	public int updateCustomer(CustomerVO customer) {
		return sqlSession.update(namespace+".updateCustomer", customer);
	}

	public void deleteManager(String id) {
		sqlSession.delete(namespace+".deleteManager", id);
	}

	public ManagerVO getManagerInfo(String id) {
		return sqlSession.selectOne(namespace+".getManagerInfo", id);
	}

	public int updateManager(ManagerVO manager) {
		return sqlSession.update(namespace+".updateManager", manager);
	}

	public int insertCustomer(CustomerVO customer) {
		return sqlSession.insert(namespace+".insertCustomer", customer);
	}

	public int insertManager(ManagerVO manager) {
		return sqlSession.insert(namespace+".insertManager", manager);
	}

	public List<ConfirmVO> getConfirmIpList() {
		return sqlSession.selectList(namespace+".getConfirmIpList");
	}

	public List<FcVO> getFcList() {
		return sqlSession.selectList(namespace+".getFcList");
	}

	public int insertFc(FcVO fc) {
		return sqlSession.insert(namespace+".insertFc", fc);
	}

	public int insertIP(ConfirmVO ip) {
		return sqlSession.insert(namespace+".insertIP", ip);
	}

	public int insertDailyLog(DailyLogVO log) {
		return sqlSession.insert(namespace+".insertDailyLog", log);
	}

	public List<DailyLogVO> getDailyLogList(SearchVO search) {
		return sqlSession.selectList(namespace+".getDailyLogList", search);
	}

	public int dailyLogCnt(SearchVO search) {
		return sqlSession.selectOne(namespace+".dailyLogCnt", search);
	}

	public int deleteFc(int id) {
		return sqlSession.delete(namespace+".deleteFc", id);
	}
	
	public int deleteIp(int id) {
		return sqlSession.delete(namespace+".deleteIp", id);
	}

	public int insertStatus(StatusVO status) {
		return sqlSession.insert(namespace+".insertStatus", status);
	}

	public int deleteStatus(int id) {
		return sqlSession.delete(namespace+".deleteStatus", id);
	}

	public int deleteLog(int id) {
		return sqlSession.delete(namespace+".deleteLog", id);
	}

	public DailyLogVO getDailyLogList(int id) {
		return sqlSession.selectOne(namespace+".getDailyLog", id);
	}

	public int updateDailyLog(DailyLogVO log) {
		return sqlSession.update(namespace+".updateDailyLog", log);
	}

	public List<DailyLogVO> getGraphList(SearchVO search) {
		return sqlSession.selectList(namespace+".getGraphList", search);
	}

	public int updateStatus(DailyLogVO vo) {
		return sqlSession.update(namespace+".updateLogStatus", vo);
	}

	public List<CustomerVO> getCustomerAll() {
		return sqlSession.selectList(namespace+".getCustomerAll");
	}

	public int changeStatus(CustomerVO vo) {
		return sqlSession.update(namespace+".changeStatus", vo);
	}

	public int changeManager(CustomerVO vo) {
		return sqlSession.update(namespace+".changeManager", vo);
	}

	public List<BoardVO> getBoardList(SearchVO search) {
		return sqlSession.selectList(namespace+".getBoardList", search);
	}
	
	public List<MemoVO> getMemoList(int id) {
		return sqlSession.selectList(namespace+".getMemoList", id);
	}

	public int getBoardCnt(SearchVO search) {
		return sqlSession.selectOne(namespace+".getBoardCnt", search);
	}

	public int insertBoard(BoardVO board) {
		return sqlSession.insert(namespace+".insertBoard", board);
	}

	public BoardVO getBoard(int id) {
		return sqlSession.selectOne(namespace+".getBoard", id);
	}

	public int updateBoard(BoardVO board) {
		return sqlSession.update(namespace+".updateBoard", board);
	}

	public int deleteBoard(int id) {
		return sqlSession.delete(namespace+".deleteBoard", id);
	}

	public int customerDupCheck(CustomerVO customer) {
		return sqlSession.selectOne(namespace+".customerDupCheck", customer);
	}

	public int getCustomerId(CustomerVO customer) {
		return sqlSession.selectOne(namespace+".getCustomerId", customer);
	}

	public void insertMemo(CustomerVO customer) {
		sqlSession.insert(namespace+".insertMemo", customer);
	}

	public void deleteMemo(int id) {
		sqlSession.delete(namespace+".deleteMemo", id);
	}
	 
}
