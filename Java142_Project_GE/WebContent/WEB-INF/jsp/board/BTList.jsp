<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.ge.vo.EmInfoVO"%>
<%@ page import="com.spring.ge.vo.BTVO"%>
<%@ page import="com.spring.ge.common.Chaebun"%>
<%@ page import="com.spring.ge.common.ChangeName"%>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
Object obj = session.getAttribute("eminfo");
EmInfoVO evo = null;
evo = new EmInfoVO();
evo = (EmInfoVO)obj;

/* 페이징을 위한 부분 */
int pageSize = 10;
int groupSize = 10;
int curPage = 1;
int totalCount = 0;
int pageNo = 0;
String aa = ""; //Search
String bb = ""; //Keyword

//Object obj2 = request.getAttribute("groupSize");
Object obj3 = request.getAttribute("curPage");
Object obj4 = request.getAttribute("pageNo");
Object obj5 = request.getAttribute("totalCount");
Object obj6 = request.getAttribute("serchData");
BTVO searchData = null;
searchData = new BTVO();
searchData = (BTVO)obj6;
aa = searchData.getSearch();
bb = searchData.getKeyword();
System.out.println("BTlist.jsp aa search>>> " + aa);
System.out.println("BTlist.jsp bb keyword>>> " + bb);

String curPage1 = obj3.toString();
//String groupSize1 = obj2.toString();
String pageNo1 = obj4.toString();
String totalCount1 = obj5.toString();

//groupSize = Integer.parseInt(groupSize1);
curPage = Integer.parseInt(curPage1);
pageNo = Integer.parseInt(pageNo1);
totalCount = Integer.parseInt(totalCount1);

System.out.println("(BTlist.jsp)curPage : " + curPage);
System.out.println("(BTList.jsp)groupSize : " + groupSize);
System.out.println("(BTList.jsp)pageNo : " + pageNo);
System.out.println("(BTList.jsp)totalCount : " + totalCount);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<link rel="stylesheet" type="text/css" href="/css/common.css" />
		<title><%=evo.getDeptname() %> 부서게시판</title>
	</head>
	<style type="text/css">
	
		.pagingAlink a{
		color: black; text-decoration: none;
		}
	    td{
		border-bottom:1px solid #D8D8D8;
		}
	
	</style>
	<script type="text/javascript" src="/js/clock.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.mainframe .loader').hide();
			setInterval("dpTime()",0);
			
			/* 검색시 필요한 데이터 확인하기 */
			var data1 = "<%=aa%>";
			var data2= "<%=bb%>";
			console.log(data1);
			console.log(data2);
			
			/* 검색 후 검색 대상과 검색 단어 출력 */
			if("<%=aa%>" != "null"){
				$("#keyword").val("<%=bb%>");
				$("#search").val("<%=aa%>");
			}
			
			/* 글쓰기 버튼 클릭 시 처리 이벤트 */
			$("#BTInsert").click(function(){
				location.href="/board/bTWrite.ge";	
			});
			
			$('#logout').click(function(){
				if(confirm('로그아웃 하시겠습니까?')){
					loading();
					location.href='/ea/geLogOut.ge';
				}else{
				}
				
			});
						
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goDetail").click(function(){
				var btno = $(this).parents("tr").attr("data-num");
				$("#btno").val(btno);
				//상세 페이지로 이동하기 위해 form 추가
				$("#ge_main").attr({
					"method" : "POST",
					"action" : "/board/bTDetail.ge"
				});
				loading();
				$("#ge_main").submit();
				
			});
			
			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchData").click(function(){
				var searchData = $("#keyword").val();
				if(!searchData){
					alert("검색어를 입력하세요");
					return;
				}
				pageResult();
			});
			
			/* 전체보기 */			
			$("#allList").click(function(){
				loading();
				location.href="/board/bTList.ge";
			});
		});
		
		function deptcdCheck1(check){
			var checkDept = check;
			var userDept = "<%=evo.getDeptcd() %>";
			if(checkDept != userDept){
				alert("접근 권한이 존재하지 않습니다.");
				return;
			}
			loading();
			$("#ge_main").attr("action","/board/bDList.ge").submit();	
		}
		function deptcdCheck2(check){
			var checkDept = check;
			var userDept = "<%=evo.getDeptcd() %>";
			if(checkDept != userDept){
				alert("접근 권한이 존재하지 않습니다.");
				return;
			}
			loading();
			$("#ge_main").attr("action","/board/bTList.ge").submit();	
		}
		
		/* 검색과 한 페이지에 보여줄 레코드 수 처리 및 페이징을 위한 실질적인 처리 함수 */
		function pageResult(){

			$("#searchDetail").attr({
				"method" : "get",
				"action" : "/board/bTList.ge"
			});
			
			$("#searchDetail").submit();				
		}
		
		function loading(){
			setTimeout($('.mainframe .loader').show(), 1000);
		}
		
	</script>
	<body>
		<div id="ge_menudiv">
			<div class="topinfo">
				<div class="myname"><%=evo.getEmname()%> 님 안녕하세요.</div>
				<div class="logout" id="logout">logout</div>
			</div>
		</div>
		<div class="ge_maindiv">
			<div class="topmenu">
				<div class="p">
					<a href="/ea/gemain.ge">메인</a>｜
					<a href="/ea/eamain.ge">전자 결재</a>｜
					<a href="#">전자메일</a>｜
					<a href="#">조직도</a>｜
					<a href="/board/boardMain.ge" style="color:#615F8D">부서게시판</a>｜
					<a href="/board/calendar.ge">일정관리</a>｜
					<a href="#">쪽지함</a>｜
					<a href="/em/myPageInfo.ge">마이페이지</a></div>
				</div><!-- <div class="p"> -->
			</div><!-- <div class="topmenu"> -->
			<div class="topdiv">
			</div><!-- <div class="topdiv"> -->
			<div class="outertable">
				<div class="ge_sidemenu">
					<div class="ge_myinfo">
						<div class="imgbox">
						<img class="myimg" src="/em_Image<%=evo.getEmpic()%>" />
						</div>
						<br>
						<div class="itsme"><%=evo.getEmname()%><br>(<%=evo.getDeptname() %>/<%=evo.getJobname() %>)</div>
					</div>
					
						<div class="menubtn"><div class="mbtneff"></div><a href="/board/bNList.ge" onclick="">공지사항</a></div>
						<br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(20); return false;">관리부 게시판</a></div>
						<a href="javascript:deptcdCheck2(20);" style="color: black">&nbsp;&nbsp;ㄴ업무게시판</a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(30); return false;">영업지원부 게시판</a></div>
						<a href="javascript:deptcdCheck2(30);" style="color: black">&nbsp;&nbsp;ㄴ업무게시판 </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(40); return false;">영업부 게시판</a></div>
						<a href="javascript:deptcdCheck2(40);" style="color: black">&nbsp;&nbsp;ㄴ업무게시판 </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div>
						<a href="#" onclick="deptcdCheck1(50); return false;">기술지원부 게시판</a>
						</div>
						<a href="javascript:deptcdCheck2(50);" style="color: black">&nbsp;&nbsp;ㄴ업무게시판 </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="/pjboard/pjBoardList.ge" onclick="">프로젝트게시판</a></div>
						<div class="menubtn"><div class="mbtneff"></div><a href="/anmsBoard/anBoardList.ge" onclick="">익명게시판</a></div>						
						<div class="clock" style="border:1px solid #000000; border-radius:1px; background:#808080; float:left; margin:10px 0 10px 0px; padding:5px 0 5px 0">
						<div align="center" style="font-size:20pt ;color:white; "class="dpTime" id="dpTime"></div>
						</div>							
					</div><!-- <div class="ge_sidemenu"> -->
					<div class="mainframe">
					<div id="noticebar" style="height:50px; width:10px; background:#999999; margin:20px 0px 0px 20px; float:left"></div>
					<div style="margin:20px; float:left; height:50px; width:400px; margin:20px 0px 0px 0px;"><h1>&nbsp;업무 게시판</h1></div>
					<form name="ge_main" id="ge_main">
						<div  style="margin:100px 0px 0px 20px; float:bottom">
						<table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;">
						<colgroup>
							<col width="20%">
							<col width="40%">
							<col width="15%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<tr>
							<td colspan="5" align="right" >
								<input type="button" value="글 쓰기" id="BTInsert" name="BTInsert">
								<br>
								<br>
							</td>
						</tr>
						<tr style="background:#999999; text-align: center;">
							<th>글번호
							<input type="hidden" id="btno" name="btno">
							</th>
							<th>제목</th>
							<th>작성자<br>(직위)</th>
							<th>작성일</th>					
							<th>조회수</th>
						</tr>
<%
Object objList = request.getAttribute("boardTaskList");
ArrayList<BTVO> boardTaskList = null;
	if(objList != null){
		boardTaskList = (ArrayList<BTVO>)objList;
		int listSize = boardTaskList.size();
		
		if(listSize == 0){
%>
		<tbody class="noData">
			<tr>
				<td colspan="5" align="center">
				<br>
				등록된 게시물이 존재하지 않습니다. 첫번째 게시글을 입력해주세요!	
				</td>
			</tr>
<%
			for(int i=0; i<9; i++){
%>
			<tr>
				<td colspan="5">
				<br>
				<br>		
				</td>
			</tr>				
<%				
			}//end of for
%>			
			
		</tbody>		
<%		
		}else{
			for(int i=0; i<listSize; i++){
				BTVO btvo = new BTVO();
				btvo = boardTaskList.get(i);
%>					
		<tbody class="notNotice">	
			<tr data-num=<%=btvo.getBtno() %>>
				<td>&nbsp;&nbsp;<%=btvo.getBtno() %></td>	
<%
			if(btvo.getBtinsertdate().equals(Chaebun.ymdFormat2())){
				if(btvo.getBtsubject().length() >= 13 ){
%>
				<td><span class="goDetail"><%=btvo.getBtsubject().substring(0,12)+"......" %> NEW</span></td>

<%					
				}else{
%>
				<td><span class="goDetail"><%=btvo.getBtsubject() %> NEW</span></td>
<%					
				}
					
			}else{
				
				if(btvo.getBtsubject().length() >= 13 ){
%>
				<td><span class="goDetail"><%=btvo.getBtsubject().substring(0,12)+"......" %></span></td>

<%					
				}else{
%>
				<td><span class="goDetail"><%=btvo.getBtsubject() %></span></td>
<%					
				}
			}
				
				String jobcd = "";
				jobcd = btvo.getJobcd();
				jobcd = ChangeName.jobcdName(jobcd);
%>				
				<td style="text-align: center;"><%=btvo.getEmname() %><br>(<%=jobcd %>)</td>
				<td style="text-align: center;"><%=btvo.getBtinsertdate() %><br></td>
				<td style="text-align: center;"><%=btvo.getBtvcnt() %><br></td>
			</tr>
		</tbody>
<%		
			}//end of for
			if(listSize < 10){
				for(int i=0; i<10-listSize; i++){
%>				
					<tbody height="500px">	
						<tr>
							<td><br><br></td>
							<td><br><br></td>
							<td><br><br></td>
							<td><br><br></td>
							<td><br><br></td>
						</tr>
					</tbody>					
<%									
				}//end of for			
			}//end of if
%>
		</table><!-- <table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;"> -->
<%						
		}//end of if-else
	}//end of if
%>								
						</div><!-- <div  style="margin:100px 0px 0px 20px; float:bottom"> -->
					</form><!-- <form name="ge_main" id="ge_main">	 -->
					<div id="qq" style="display:table; margin:10px; float:left">
					<!-- 검색버튼 -->
					<div id="검색버튼 시작" style="display:table-cell;">
						<form id="searchDetail">
						<table style="padding:0px 0px 0px 16px">
							<tr>
								<td>
									<select id="search" name="search" style="height:26px; width:51px">
									<option value="btsubject">제목</option>
									</select>
								</td>
								<td>
									<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" style="height:20px;"/>
								</td>
								<td>
									<input type="button" id="searchData" name="searchData" value="검색" style="height:26px; width:43px;" />
								</td>
								<td>
									<input type="button" id="allList" name="allList" value="전체보기" style="height:26px; width:70px;" />
								</td>
								<td align="right" style="width:600px;">
									<div class="pagingAlink">
									<jsp:include page="paging.jsp" flush="true" >
									<jsp:param name="url" value="/board/bTList.ge"/>
									<jsp:param name="str" value=""/>
									<jsp:param name="search" value="<%=aa%>"/>
									<jsp:param name="keyword" value="<%=bb%>"/>
									<jsp:param name="pageSize" value="<%=String.valueOf(pageSize) %>"/>
									<jsp:param name="groupSize" value="<%=String.valueOf(groupSize)%>"/>
									<jsp:param name="curPage" value="<%=String.valueOf(curPage) %>"/>
									<jsp:param name="totalCount" value="<%=String.valueOf(totalCount)%>"/>
									</jsp:include>
									</div><!-- <div class="pagingAlink"> -->
								</td>
							</tr>
						</table>
						</form><!-- <form id="searchDetail"> -->
						</div><!-- <div id="검색버튼 시작" style="display:table-cell;"> -->
					</div><!-- <div id="qq" style="display:table; margin:10px; float:left"> -->				
					</div><!-- <div class="mainframe"> -->	
				</div><!-- <div class="outertable"> -->
				<div class="bottom">
				<div class="bottominfo">
				GE Project ｜ 서울시 서초구 강남대로 459 (서초동, 백암빌딩)<br>
				TEL : 02-1234-5678 / FAX : 02-1234-5678<br>
				Copyright ⓒ GE Project. All Rights Reserved.
				</div><!-- <div class="bottominfo"> -->
				</div><!-- <div class="bottom"> -->
		</div><!-- <div class="ge_maindiv"> -->
	</body>
</html>