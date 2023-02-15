package com.project.mj.manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.mj.manager.domain.BoardVO;
import com.project.mj.manager.domain.ConfirmVO;
import com.project.mj.manager.domain.Criteria;
import com.project.mj.manager.domain.CustomerVO;
import com.project.mj.manager.domain.DailyLogVO;
import com.project.mj.manager.domain.FcVO;
import com.project.mj.manager.domain.ManagerVO;
import com.project.mj.manager.domain.MemoVO;
import com.project.mj.manager.domain.PageMaker;
import com.project.mj.manager.domain.SearchVO;
import com.project.mj.manager.domain.StatusVO;
import com.project.mj.manager.service.ManagerService;

@Controller
public class ManagerController {
	@Autowired
	private ManagerService service; 
	
	//로그인
	@RequestMapping(value="/login", method=RequestMethod.POST) 
	public ModelAndView loginUser(ManagerVO managerVO, HttpServletResponse response, HttpServletRequest request) throws Exception { 
		ModelAndView nextView = null;
		
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null) ip = request.getRemoteAddr();
		 		
		List<ConfirmVO> confirmIps = service.getConfirmIpList();
		boolean confirm = false;
		for(ConfirmVO val : confirmIps) {
			if(val.getIp().equals(ip)) {
				confirm = true;
				break;
			}
		}
		ManagerVO userData = service.managerLogin(managerVO);
		if(userData == null) { 
			//일치하는 사용자 정보가 없을때
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('ID 혹은 비밀번호를 확인하세요.'); history.go(-1);</script>");
            out.flush();
            confirm = true;
		}else { 
			if(userData.getStatus().equals("0")) { //일치하는 사원 정보가 있지만 STATUS 값이 0인경우 (퇴사)
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('퇴사한 사용자 입니다.'); history.go(-1);</script>");
	            out.flush();
			}else if(userData.getStatus().equals("1")) {//정상사용자의 경우
				nextView = new ModelAndView("main");
				//세션에 사용자 데이터 저장
				HttpSession httpSession = request.getSession(true);
				httpSession.setAttribute("manager", userData);
				httpSession.setAttribute("position", userData.getPosition());
			}
		}
		if(!confirm) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('접속 불가능한 IP입니다. 관리자에게 문의하세요.'); history.go(-1);</script>");
            out.flush();
		}
		return nextView;
	}
	
	//로그아웃
	@GetMapping("/logout") 
	public ModelAndView logoutManager(){ 
		ModelAndView nextView = new ModelAndView("logout");
		return nextView;
	}
	
	//홈
	@GetMapping("/home") 
	public ModelAndView home(){ 
		ModelAndView nextView = new ModelAndView("main");
		return nextView;
	}
	
	//메뉴 액션
  	@GetMapping("/menu/{menu}") 
  	public ModelAndView goMenu(@PathVariable("menu") String menu, HttpServletRequest request, Criteria cri, SearchVO searchVO) throws Exception { 
  		ModelAndView nextView = null;
  		HttpSession httpSession = request.getSession(true);
		if(menu.equals("menu0")){ //공지사항
			nextView = boardList(searchVO, request, cri);
		}else if(menu.equals("menu1")){ //고객관리
  			nextView = customerList(searchVO, request, cri);
  		}else if(menu.equals("menu2")) { //직원관리
  			nextView = managerList(searchVO, request, cri);
  		}else if(menu.equals("menu3_1")) { //일지리스트
  			nextView = dailyLogList(searchVO, request, cri);
  		}else if(menu.equals("menu3_2")) { //정산
  			nextView = graphList(searchVO, request);
  		}else if(menu.equals("menu4")) { //금융사관리
  			nextView = fcList();
  		}else if(menu.equals("menu5")) { //IP관리
  			nextView = confirmIpList();
  		}else if(menu.equals("menu6")) { //상태값관리
  			nextView = statusList();
  		}
  		httpSession.setAttribute("menu", menu);
  		return nextView;
  	}
  	
  	//공지사항
  	@RequestMapping(value="/boardSearch", method=RequestMethod.POST) 
  	private ModelAndView boardList(SearchVO search, HttpServletRequest request, Criteria cri) {
  		ModelAndView nextView = new ModelAndView("boardList");
  		HttpSession httpSession = request.getSession();
  		ManagerVO manager = (ManagerVO) httpSession.getAttribute("manager");
  		nextView.addObject("position", manager.getPosition());
  		
  		search.setCri(cri);
  		//고객리스트
  		List<BoardVO> boardList = service.getBoardList(search); 
  		int totalCnt = service.boardCnt(search);
  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri);
  		pageMaker.setTotalCount(totalCnt);
  		pageMaker.setSearchWriter(search.getSearchWriter());
  		pageMaker.setSearchTitle(search.getSearchTitle());
  		pageMaker.setStartdate(search.getStartdate());
  		pageMaker.setEnddate(search.getEnddate());
  		
  		nextView.addObject("pageMaker", pageMaker);
  		nextView.addObject("boardList", boardList);
  		nextView.addObject("search", search);
  		nextView.addObject("totalCnt", totalCnt);
  		return nextView;
  	}
  	//고객관리
  	@RequestMapping(value="/customerSearch", method=RequestMethod.POST) 
	private ModelAndView customerList(SearchVO search, HttpServletRequest request, Criteria cri) {
		ModelAndView nextView = new ModelAndView("customerList");
		HttpSession httpSession = request.getSession();
  		ManagerVO manager = (ManagerVO) httpSession.getAttribute("manager");
		if(!manager.getPosition().equals("관리자")) {
			search.setManager(manager.getId());
		}else{
			search.setManager("");
		}
		if(search.getSearchKey() == null) {
			search.setSearchKey("name");
		}
		search.setCri(cri);
		//고객리스트
		List<CustomerVO> customerList = service.getCustomerList(search); 
		int totalCnt = service.customerCnt(search);
		List<StatusVO> statusList = service.getStatusList();
		
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchStatus("1");
		List<ManagerVO> managerList = service.getManagerList(searchVO);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setSearchKey(search.getSearchKey());
		if(search.getSearchStatus() == null) {
			pageMaker.setSearchStatus(null);
		}else{
			pageMaker.setSearchStatus(String.valueOf(search.getSearchStatus()));
		}
		pageMaker.setSearchKeyword(search.getSearchKeyword());
		pageMaker.setStartdate(search.getStartdate());
		pageMaker.setEnddate(search.getEnddate());
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCnt);
		
		nextView.addObject("pageMaker", pageMaker);
		nextView.addObject("customerList", customerList);
		nextView.addObject("statusList", statusList);
		nextView.addObject("managerList", managerList);
		nextView.addObject("search", search);
		nextView.addObject("totalCnt", totalCnt);
		nextView.addObject("position", manager.getPosition());
		return nextView;
	}
  	
  	//직원관리
  	@RequestMapping(value="/managerSearch", method=RequestMethod.POST) 
	private ModelAndView managerList(SearchVO search, HttpServletRequest request, Criteria cri) {
		ModelAndView nextView = new ModelAndView("managerList");
		
		search.setCri(cri);
		//고객리스트
		List<ManagerVO> managerList = service.getManagerList(search); 
		int totalCnt = service.managerCnt(search);
		
		HttpSession httpSession = request.getSession();
  		ManagerVO manager = (ManagerVO) httpSession.getAttribute("manager");
  		nextView.addObject("position", manager.getPosition());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCnt);
		if(search.getSearchStatus() == null) {
			pageMaker.setSearchStatus("9");
		}else {
			pageMaker.setSearchStatus(search.getSearchStatus());
		}
		pageMaker.setSearchKey(search.getSearchKey());
		pageMaker.setSearchKeyword(search.getSearchKeyword());
		
		nextView.addObject("pageMaker", pageMaker);
		nextView.addObject("managerList", managerList);
		nextView.addObject("search", search);
		nextView.addObject("totalCnt", totalCnt);
		return nextView;
	}
  	
  	//일지 리스트
  	@RequestMapping(value="/dailyLogList", method=RequestMethod.POST) 
  	private ModelAndView dailyLogList(SearchVO search, HttpServletRequest request, Criteria cri) {
  		ModelAndView nextView = new ModelAndView("dailyLogList");
  		HttpSession httpSession = request.getSession();
  		ManagerVO manager = (ManagerVO) httpSession.getAttribute("manager");
		if(!manager.getPosition().equals("관리자")) {
			search.setManager(manager.getName());
		}
		if(search.getName() == null) {
			search.setSearchStatus("9");
		}
		
  		search.setCri(cri);
  		//일지리스트
  		List<DailyLogVO> dailyLogList = service.getDailyLogList(search); 
  		int totalCnt = service.dailyLogCnt(search);
  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri);
  		pageMaker.setTotalCount(totalCnt);
  		pageMaker.setDbenddate(search.getDbenddate());
  		pageMaker.setDbstartdate(search.getDbstartdate());
  		pageMaker.setName(search.getName());
  		pageMaker.setManager(search.getManager());
  		pageMaker.setSearchStatus(String.valueOf(search.getSearchStatus()));
  		pageMaker.setDepositenddate(search.getDepositenddate());
  		pageMaker.setDepositstartdate(search.getDepositstartdate());
  		
  		nextView.addObject("pageMaker", pageMaker);
  		nextView.addObject("dailyLogList", dailyLogList);
  		nextView.addObject("search", search);
  		nextView.addObject("totalCnt", totalCnt);
  		nextView.addObject("position", manager.getPosition());
  		return nextView;
  	}
  	
  	//정산 리스트
  	@RequestMapping(value="/graphList", method=RequestMethod.POST) 
  	private ModelAndView graphList(SearchVO search, HttpServletRequest request) {
  		ModelAndView nextView = new ModelAndView("graphList");
  		Date date = new Date();
  		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  		
  		if(search.getDbstartdate() == null) {
  			search.setDbstartdate(sdf.format(date));
  		}
  		
  		if(search.getDbenddate() == null) {
  			search.setDbenddate(sdf.format(date));
  		}
  		
  		//정산데이터
  		List<DailyLogVO> graphList = service.getGraphList(search); 
  		if(graphList.size() > 0) {
  			nextView.addObject("totalmoney", graphList.get(0).getTotalmoney());
  			nextView.addObject("totaldmoney", graphList.get(0).getTotaldmoney());
  		}else{
  			nextView.addObject("totalmoney", 0);
  			nextView.addObject("totaldmoney", 0);
  		}
  		nextView.addObject("graphList", graphList);
  		nextView.addObject("search", search);
  		return nextView;
  	}
  	
  	//금융사 관리
  	@RequestMapping(value="/fcList", method=RequestMethod.POST) 
  	private ModelAndView fcList() {
  		ModelAndView nextView = new ModelAndView("fcList");
  		//금융사리스트
  		List<FcVO> fcList = service.getFcList();
  		
  		nextView.addObject("fcList", fcList);
  		return nextView;
  	}
  	
  	//상태값 관리
  	@RequestMapping(value="/statusList", method=RequestMethod.POST) 
  	private ModelAndView statusList() {
  		ModelAndView nextView = new ModelAndView("statusList");
  		//상태값리스트
  		List<StatusVO> statusList = service.getStatusList();
  		
  		nextView.addObject("statusList", statusList);
  		return nextView;
  	}
  	
  	//접속IP 관리
  	@RequestMapping(value="/confirmIpList", method=RequestMethod.POST) 
  	private ModelAndView confirmIpList() {
  		ModelAndView nextView = new ModelAndView("confirmIpList");
  		//접속Ip리스트
  		List<ConfirmVO> ipList = service.getConfirmIpList();
  		
  		nextView.addObject("ipList", ipList);
  		return nextView;
  	}
  	
  	//고객수정
  	@RequestMapping(value="/customerModify", method=RequestMethod.POST) 
  	private ModelAndView customerModify(CustomerVO customer) {
  		ModelAndView nextView = new ModelAndView("customerInfo");
  		int ok = service.updateCustomer(customer);
  		if(!customer.getMemo().equals("")) {
  			service.insertMemo(customer);
  		}
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		
  		nextView.addObject("customer", customer);
		nextView.addObject("saveYn", saveYn);
		return nextView;
  	}
  	
  	//직원수정
  	@RequestMapping(value="/managerModify", method=RequestMethod.POST) 
  	private ModelAndView managerModify(ManagerVO manager) {
  		ModelAndView nextView = new ModelAndView("managerInfo");
  		int ok = service.updateManager(manager);
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		
  		nextView.addObject("manager", manager);
		nextView.addObject("saveYn", saveYn);
		return nextView;
  	}
  	
  	//일지 수정
  	@RequestMapping(value="/dailyLogModify", method=RequestMethod.POST) 
  	private ModelAndView dailyLogUpdate(DailyLogVO log) {
  		ModelAndView nextView = new ModelAndView("dailyLogInfo");
  		int ok = service.updateDailyLog(log);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("log", log);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//확정처리 
  	@RequestMapping(value="/statusChange/{status}/{id}/{page}", method=RequestMethod.GET) 
  	private ModelAndView statusChange(@PathVariable("status") String status, @PathVariable("id") int id, @PathVariable("page") int page, Criteria cri, HttpServletRequest request) {
  		SearchVO searchVO = new SearchVO();
  		DailyLogVO vo = new DailyLogVO();
  		if(status.equals("ok")) {
  			vo.setStatus(1);
  		}else {
  			vo.setStatus(0);
  		}
  		vo.setId(id);
  		int ok = service.statusChange(vo);
  		searchVO.setSearchStatus("9");
  		cri.setPage(page);
  		ModelAndView nextView = dailyLogList(searchVO, request, cri);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	//고객 상태변경
  	@GetMapping(value="/changeStatus/{id}/{status}/{pageNum}") 
  	private ModelAndView changeStatus(SearchVO searchVO, @PathVariable("status") String status, @PathVariable("id") int id, @PathVariable("pageNum") int page, Criteria cri, HttpServletRequest request) {
  		CustomerVO vo = new CustomerVO();
  		vo.setStatus(status);
  		vo.setId(id);
  		int ok = service.changeStatus(vo);
  		cri.setPage(page);
  		ModelAndView nextView = customerList(searchVO, request, cri);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//공지사항 수정페이지
  	@RequestMapping(value="/boardModify/{id}", method=RequestMethod.GET) 
  	private ModelAndView boardModify(@PathVariable("id") int id) {
  		ModelAndView nextView = new ModelAndView("boardModify");
  		
  		BoardVO board = service.getBoard(id);
  		nextView.addObject("board", board);
  		return nextView;
  	}
  	
  	//고객 담당자변경
  	@GetMapping(value="/changeManager/{id}/{manager}/{pageNum}") 
  	private ModelAndView changeManager(SearchVO searchVO, @PathVariable("manager") String manager, @PathVariable("id") int id, @PathVariable("pageNum") int page, Criteria cri, HttpServletRequest request) {
  		CustomerVO vo = new CustomerVO();
  		vo.setManager(manager);
  		vo.setId(id);
  		int ok = service.changeManager(vo);
  		cri.setPage(page);
  		ModelAndView nextView = customerList(searchVO, request, cri);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//공지사항추가
  	@RequestMapping(value="/boardInsert", method=RequestMethod.POST) 
  	private ModelAndView boardInsert(BoardVO board) {
  		ModelAndView nextView = new ModelAndView("boardAdd");
  		int ok = service.insertBoard(board);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("board", board);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//공지사항수정
  	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST) 
  	private ModelAndView boardUpdate(BoardVO board) {
  		ModelAndView nextView = new ModelAndView("boardAdd");
  		int ok = service.updateBoard(board);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("board", board);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//공지사항 수정페이지
  	@GetMapping("/deleteBoard/{id}") 
  	private ModelAndView deleteBoard(@PathVariable("id") int id, Criteria cri, HttpServletRequest request) {
  		SearchVO searchVO = new SearchVO();
  		int ok = service.deleteBoard(id);
  		
  		ModelAndView nextView = boardList(searchVO, request, cri);
  		return nextView;
  	}
  	
  	//고객추가
  	@RequestMapping(value="/customerInsert", method=RequestMethod.POST) 
  	private ModelAndView customerInsert(CustomerVO customer, HttpServletResponse response) {
  		ModelAndView nextView = new ModelAndView("customerInfo");
  		int dupCnt = service.customerDupCheck(customer);
  		String saveYn = "N";
  		if(dupCnt > 0) {
  			try {
  			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out;
			out = response.getWriter();
			out.println("<script>alert('전화번호가 중복되는 고객이 존재합니다.'); history.go(-1);</script>");
			out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
  		}else{
	  		int ok = service.insertCustomer(customer);
	  		
	  		int id = service.getCustomerId(customer);
	  		customer.setId(id);
	  		
	  		service.insertMemo(customer);
	  		
	  		if(ok == 1) {
	  			saveYn = "Y";
	  		}
  		}
  		nextView.addObject("customer", customer);
		nextView.addObject("saveYn", saveYn);
		return nextView;
  	}
  	
  	//직원추가
  	@RequestMapping(value="/managerInsert", method=RequestMethod.POST) 
  	private ModelAndView managerInsert(ManagerVO manager) {
  		ModelAndView nextView = new ModelAndView("managerInfo");
  		int ok = service.insertManager(manager);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("manager", manager);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//일지 작성
  	@RequestMapping(value="/dailyLogInsert", method=RequestMethod.POST) 
  	private ModelAndView dailyLogInsert(DailyLogVO log) {
  		ModelAndView nextView = new ModelAndView("writeDailyLog");
  		int ok = service.insertDailyLog(log);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		nextView.addObject("log", log);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//금융사 추가
  	@RequestMapping(value="/fcInsert", method=RequestMethod.POST) 
  	private ModelAndView fcInsert(FcVO fc) {
  		ModelAndView nextView = new ModelAndView("fcList");
  		int ok = service.insertFc(fc);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		
  		//금융사리스트
  		List<FcVO> fcList = service.getFcList();
  		
  		nextView.addObject("fcList", fcList);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//IP 추가
  	@RequestMapping(value="/ipInsert", method=RequestMethod.POST) 
  	private ModelAndView ipInsert(ConfirmVO ip) {
  		ModelAndView nextView = new ModelAndView("confirmIpList");
  		int ok = service.insertConfirmIp(ip);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		
  		//접속Ip리스트
  		List<ConfirmVO> ipList = service.getConfirmIpList();
  		
  		nextView.addObject("ipList", ipList);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
  	
  	//상태값 추가
  	@RequestMapping(value="/statusInsert", method=RequestMethod.POST) 
  	private ModelAndView statusInsert(StatusVO status) {
  		ModelAndView nextView = new ModelAndView("statusList");
  		int ok = service.insertStatus(status);
  		
  		String saveYn = "N";
  		if(ok == 1) {
  			saveYn = "Y";
  		}
  		//상태값리스트
  		List<StatusVO> statusList = service.getStatusList();
  		
  		nextView.addObject("statusList", statusList);
  		nextView.addObject("saveYn", saveYn);
  		return nextView;
  	}
	
  	//고객추가 페이지 이동
  	@GetMapping("/customerAdd") 
  	public ModelAndView customerAdd(){ 
  		ModelAndView nextView = new ModelAndView("customerAdd");
  		//상태리스트 조회
  		List<StatusVO> statusList = service.getStatusList();
  		//담당자 리스트
  		SearchVO search = new SearchVO();
  		search.setSearchStatus("1");
  		List<ManagerVO> managerList = service.getManagerList(search);
  		nextView.addObject("statusList", statusList);
  		nextView.addObject("managerList", managerList);
  		return nextView;
  	}
  	
  	//공지사항 추가
  	@GetMapping("/boardAdd") 
  	public ModelAndView boardAdd(){ 
  		ModelAndView nextView = new ModelAndView("boardAdd");
  		return nextView;
  	}
  	
  	//직원추가 페이지 이동
  	@GetMapping("/managerAdd") 
  	public ModelAndView managerAdd(){ 
  		ModelAndView nextView = new ModelAndView("managerAdd");
  		return nextView;
  	}
  	
	//고객삭제
	@GetMapping("/deleteCustomer/{id}") 
	private ModelAndView deleteCustomer(@PathVariable("id") int id, Criteria cri, HttpServletRequest request) {
		SearchVO searchVO = new SearchVO();
		service.deleteCustomer(id);
		ModelAndView nextView = customerList(searchVO, request, cri);
		return nextView;
	}
	
	//메모삭제
	@GetMapping("/deleteMemo/{id}/{cid}") 
	private ModelAndView deleteMemo(@PathVariable("id") int id, @PathVariable("cid") int cid,Criteria cri, HttpServletRequest request) {
		service.deleteMemo(id);
		ModelAndView nextView = customerInfo(cid, cri, request);
		return nextView;
	}
	
	//일지삭제
	@GetMapping("/deleteLog/{id}") 
	private ModelAndView deleteLog(@PathVariable("id") int id, Criteria cri, HttpServletRequest request) {
		SearchVO searchVO = new SearchVO();
		service.deleteLog(id);
		ModelAndView nextView = dailyLogList(searchVO, request, cri);
		return nextView;
	}
	
	//직원삭제
	@GetMapping("/deleteManager/{id}") 
	private ModelAndView deleteManager(@PathVariable("id") String id, Criteria cri, HttpServletRequest request) {
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchStatus("9");
		service.deleteManager(id);
		ModelAndView nextView = managerList(searchVO, request, cri);
		return nextView;
	}
	
	//굼융사 삭제
	@GetMapping("/deleteFc/{id}") 
	private ModelAndView deleteFc(@PathVariable("id") int id) {
		ModelAndView nextView = new ModelAndView("fcList");
		service.deleteFc(id);
		//금융사리스트
  		List<FcVO> fcList = service.getFcList();
  		nextView.addObject("fcList", fcList);
		return nextView;
	}
	
	//Ip 삭제
	@GetMapping("/deleteIp/{id}") 
	private ModelAndView deleteIp(@PathVariable("id") int id) {
		ModelAndView nextView = new ModelAndView("confirmIpList");
		service.deleteIp(id);
		//접속Ip리스트
  		List<ConfirmVO> ipList = service.getConfirmIpList();
  		
  		nextView.addObject("ipList", ipList);
  		return nextView;
	}
	
	//상태값 삭제
	@GetMapping("/deleteStatus/{id}") 
	private ModelAndView deleteStatus(@PathVariable("id") int id) {
		ModelAndView nextView = new ModelAndView("statusList");
		service.deleteStatus(id);
		//상태값 리스트
		List<StatusVO> statusList = service.getStatusList();
		
		nextView.addObject("statusList", statusList);
		return nextView;
	}
	
	//고객정보팝업
	@GetMapping("/boardInfo/{id}") 
	private ModelAndView boardInfo(@PathVariable("id") int id) {
		ModelAndView nextView = new ModelAndView("boardInfo");
		BoardVO board = service.getBoard(id);
		nextView.addObject("board", board);
		return nextView;
	}
	
	//고객정보팝업
	@GetMapping("/customerInfo/{id}") 
	private ModelAndView customerInfo(@PathVariable("id") int id, Criteria cri, HttpServletRequest request) {
		ModelAndView nextView = new ModelAndView("customerInfo");
		CustomerVO customer = service.getCustomerInfo(id);
		List<StatusVO> statusList = service.getStatusList();
		List<MemoVO> memoList = service.getMemoList(id);
		SearchVO search = new SearchVO();
		search.setSearchStatus("1");
		List<ManagerVO> managerList = service.getManagerList(search);
		
		nextView.addObject("customer", customer);
		nextView.addObject("statusList", statusList);
		nextView.addObject("managerList", managerList);
		nextView.addObject("memoList", memoList);
		return nextView;
	}
	
	//일지수정팝업
	@GetMapping("/logInfo/{id}") 
	private ModelAndView dailyLogInfo(@PathVariable("id") int id, Criteria cri, HttpServletRequest request) {
		ModelAndView nextView = new ModelAndView("dailyLogInfo");
		DailyLogVO log = service.getDailyLog(id);
		List<FcVO> fcList = service.getFcList();
		nextView.addObject("log", log);
		nextView.addObject("fcList", fcList);
		return nextView;
	}
	
	//직원정보팝업
	@GetMapping("/managerInfo/{id}") 
	private ModelAndView managerInfo(@PathVariable("id") String id, Criteria cri, HttpServletRequest request) {
		ModelAndView nextView = new ModelAndView("managerInfo");
		ManagerVO manager = service.getManagerInfo(id);
		nextView.addObject("manager", manager);
		return nextView;
	}
	
	//일지 작성 페이지 이동
  	@GetMapping("/writeLog/{id}") 
  	public ModelAndView writeLog(@PathVariable("id") int id){ 
  		ModelAndView nextView = new ModelAndView("writeDailyLog");
  		//고객 정보
  		CustomerVO customer = service.getCustomerInfo(id);
  		//금융사리스트
  		List<FcVO> fcList = service.getFcList();
  		nextView.addObject("fcList", fcList);
  		nextView.addObject("customer", customer);
  		return nextView;
  	}
	
}