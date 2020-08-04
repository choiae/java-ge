<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.ge.vo.EmInfoVO"%>
<%@ page import="com.spring.ge.vo.BNVO"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
Object obj = session.getAttribute("eminfo");
EmInfoVO evo = null;
evo = new EmInfoVO();
evo = (EmInfoVO)obj;

String jobCdCheck = evo.getJobcd();
System.out.println("jobCdCheck >> " + jobCdCheck);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<link rel="stylesheet" type="text/css" href="/css/boardDetail.css" />
		<title></title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="/js/clock.js"></script>
		<script type="text/javascript" src="/include/js/HuskyEZCreator.js" charset="EUC-KR"></script>
		<script type="text/javascript">	
			var oEditors = [];
			$(function(){
				
				$("#admin").hide();
				$("#adminbutton").hide();
				$("#default").show();
				$("#defaultbutton").show();
				
				if(<%=jobCdCheck%> == 01){
					$("#default").hide();
					$("#defaultbutton").hide();
					$("#admin").show();
					$("#adminbutton").show();				
				}				
				
				$('.mainframe .loader').hide();
				setInterval("dpTime()",0);
				
				nhn.husky.EZCreator.createInIFrame({
					 oAppRef: oEditors,
					 elPlaceHolder: "bncontent",
					 sSkinURI: "/include/SmartEditor2Skin.html",
					 htParams : {
						 bUseToolBar : true,
						 bUseVerticalResize : true,
						 bUseModeChanger : true,
						 fOnBeforeUnload : function(){
							 
						 }
					 },
					 fOnAppLoad : function(){
						 oEditors.getById["bncontent"].exec("PASTE_HTML", [ "" ]);
					 },
					 fCreator: "createSEditor2"
					});
				
				$("#BNInsert").click(function(){
					var subject = $("#bnsubject").val();
					if(!subject){
						if(!confirm("제목 없이 입력하시겠습니까?")){
							return;
						}
					}
					if(confirm("글을 저장하시겠습니까?")){
						
					oEditors.getById["bncontent"].exec("UPDATE_CONTENTS_FIELD", []);
					
					$("#ge_main").attr({
						"method" : "POST",
						"action" : "/board/bNWriteInsert.ge"
					});
					loading();
					$("#ge_main").submit();	
						
					}					
					
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#BNList").click(function(){
					
					if(confirm("목록으로 돌아가시겠습니까?")){
					loading();
					location.href="/board/bNList.ge"
						
					}
				});	
				
				$('#logout').click(function(){
					if(confirm('로그아웃 하시겠습니까?')){
						loading();
						location.href='/ea/geLogOut.ge';
					}else{
					}
					
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
			
			function loading(){
				setTimeout($('.mainframe .loader').show(), 1000);
			}
		</script>
	</head>
	<body>
		<div id="ge_menudiv">
			<div class="topinfo">
				<div class="myname"><%=evo.getEmname()%> 님 안녕하세요.</div>
				<div class="logout" id="logout">logout</div>
			</div><!-- <div class="topinfo"> -->
		</div><!-- <div id="ge_menudiv"> -->
		<div class="ge_maindiv">
			<div class="topmenu" id="default">
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
			<div class="topmenu" id="admin">
                  <div class="p">
	                  <a href="/board/bNList.ge">공지사항</a>｜
	                  <a href="/board/calendar.ge">일정관리</a>｜
	                  <a href="/em/emAllSelect.ge">사원관리</a>｜
	                  <a href="/em/ctAllSelect.ge">근태관리</a>｜
	                  <a href="#">교육사항</a>｜
	                  <a href="#">인사평가</a>
                  </div><!--  <div class="p"> -->
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
						<div id="defaultbutton">
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
							</div><!-- <div id = defaultbutton> -->
							<div id="adminbutton">
							<div class="menubtn"><div class="mbtneff"></div><a href="/board/bNList.ge" >공지사항</a></div>
							<br><br>
							<br><br>
							<br><br>
							<br><br>
							<br><br>
							<br><br>
							<br><br>
							<br>
							</div><!-- <div id = admintbutton> -->		
						<div class="clock" style="border:1px solid #000000; border-radius:1px; background:#808080; float:left; margin:10px 0 10px 0px; padding:5px 0 5px 0">
						<div align="center" style="font-size:20pt ;color:white; "class="dpTime" id="dpTime"></div>
						</div>	
					</div><!-- <div class="ge_sidemenu"> -->
					<div class="mainframe">
						<div id="noticebar" style="height:50px; width:10px; background:#999999; margin:20px 0px 0px 20px; float:left"></div>
						<div style="margin:20px; float:left; height:50px; width:400px; margin:20px 0px 0px 0px;"><h1>&nbsp;글쓰기</h1></div>
						<form name="ge_main" id="ge_main">
						<div style="margin:100px 0px 0px 20px; float:bottom">
						<table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;">
							<tr>
								<td>
								<br>
								<br>
								<br>
									<table id="BNWrite" width="900px" height="430px" style="border-collapse: collapse; border:0px;">
										<colgroup>
											<col width="15%">
											<col width="25%">
											<col width="25%">
											<col width="25%">
										</colgroup>
										<tr height="50px" style="background:#9E9E9E; text-align:center;">
											<th>작성자</th>
											<th><%=evo.getEmid() %> ( <%=evo.getEmname() %> )</th>
											<th>부서</th>
											<th><%=evo.getDeptname() %> ( <%=evo.getJobname() %> )</th>
											
										</tr>
										<tr height="50x">
											<th style="background:#9E9E9E; text-align: center;">제목</th>
											<td colspan="3"><input type="text" name="bnsubject" id="bnsubject" style="width:100%; height:100%; border:0px;" placeholder="   제목을 입력해주세요"></td>
										</tr>
										<tr height="300px">
											<th style="background:#9E9E9E; text-align:center;">내용</th>
											<td colspan="3" style="width:100%; height:100%">
												<textarea name="bncontent" id="bncontent"
												rows="10" cols="100" style="width:100%; height:300px; color:#666666;" > 내용 없음 </textarea>					
											</td>
										</tr>
										<tr height="50px">
											<td colspan="4" align="right">
												<div id="BNButton">
													<input type="button" value="저장" name="BNInsert" id="BNInsert">
													<input type="button" value="목록" name="BNList" id="BNList">			
												</div>												
											</td>
										</tr>
									</table>		
								</td>
							</tr>
						
						
						
						</table><!-- <table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;"> -->
						</div><!-- <div  style="margin:100px 0px 0px 20px; float:bottom"> -->
						</form><!-- <form name="ge_main" id="ge_main"> -->
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