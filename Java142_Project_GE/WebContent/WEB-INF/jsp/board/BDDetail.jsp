<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="com.spring.ge.vo.EmInfoVO"%>
<%@ page import="com.spring.ge.vo.BDVO"%>
<%@ page import="com.spring.ge.common.ChangeName"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
Object obj = session.getAttribute("eminfo");
EmInfoVO evo = null;
evo = new EmInfoVO();
evo = (EmInfoVO)obj;

Object objDetail = request.getAttribute("boardDepartmentDetail");
BDVO bdvo = null;
bdvo = new BDVO();
bdvo = (BDVO)objDetail;	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>상세</title>
		
		<link rel="stylesheet" type="text/css" href="/css/boardDetail.css" />
		
		<script type="text/javascript" src="/js/clock.js"></script>
		<style type="text/css">
		.pagingAlink a{
		color: black; text-decoration: none;
		}  
		th, td {
		padding: 3px;
		}
		table {
		width: 900px;;
		}
		</style>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$('.mainframe .loader').hide();
			setInterval("dpTime()",0);
			
			var check1 = "<%=evo.getEmno() %>";
			var check2 = "<%=bdvo.getEmno() %>";
			$("#UpDelbutton").hide();
			
			if(check1 == check2){
				
				$("#UpDelbutton").show();
			}
				
			
			/* 첨부파일 이미지 보여주기 위한 속성 추가 */
			var fileImage = '<%=bdvo.getBdfilepath() %>';
			console.log("fileImage >> " + fileImage);
			if(fileImage != null){
				$("#fileImage").attr({
					src 	: "/uploadStorage/"+fileImage,
					width 	: "300px",
					height	: "250px"
				});
			}
			
			/* 게시글 쓰기 */
			$("#BDInsert").click(function(){
				loading();
				location.href="/board/bDWrite.ge";			
			});
			/* 게시글 답글 쓰기 */
			$("#RefBInsert").click(function(){
				if(<%=bdvo.getBdstep()%>==1){
					alert("더이상 답글을 쓸 수 없는 상태입니다. \n새글 작성 바랍니다.");
					return;
				}
				var bdstep = 1;
				$("#bdstep").val(bdstep);
				
				loading();
				$("#ge_main").attr("action","/board/bDWrite.ge").submit();			
			});
			
			/* 게시글 수정하기 */
			$("#BDUForm").click(function(){
				loading();
				$("#BDDetail").attr("action","/board/bDUForm.ge").submit();
				
			});
			
			/* 게시글 삭제하기 */
			$("#BDDelete").click(function(){				
				var confirmText = confirm("삭제하시겠습니까?");
				if(confirmText == true){
					loading();
					$("#BDDetail").attr("action","/board/bDDelete.ge").submit();
				}				
			});
			
			/* 목록으로 돌아가기 */
			$("#BDList").click(function(){		
				loading();
				$("#BDDetail").attr("action","/board/bDList.ge").submit();
								
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
		<style type="text/css">

		  
		
		</style>
	</head>
	<body>
		<div id="ge_menudiv">
			<div class="topinfo">
				<div class="myname"><%=evo.getEmname()%> 님 안녕하세요.</div>
				<div class="logout" id="logout">logout</div>
			</div><!-- <div class="topinfo"> -->
		</div><!-- <div id="ge_menudiv"> -->
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
						<div style="margin:20px; float:left; height:50px; width:400px; margin:20px 0px 0px 0px;"><h1>&nbsp;상세보기</h1></div>
						<form id="BDDetailForm" name="BDDetailForm">		
							<input type="hidden" id="deptcd" name="deptcd" 	value="<%=evo.getDeptcd()%>">				
						</form>
						<form id="BDDetail" name="BDDetail">		
							<input type="hidden" id="bdno"	 name="bdno"  value="<%=bdvo.getBdno()%>">	
						</form>
						<form name="ge_main" id="ge_main">
						<input type="hidden" id="bdref" name="bdref" value="<%=bdvo.getBdref()%>">
						<input type="hidden" id="bdstep" name="bdstep" value="<%=bdvo.getBdstep()%>">
						<div style="margin:100px 0px 0px 20px; float:bottom">
						<table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;">
							<tr>
								<td>
									<div id="UpDelbutton" style="margin:0px 0px 0px 0px;">
										<table>
											<tr>
												<td align="right">
												<input type="button" value="글수정하기" id="BDUForm" name="BDUForm"> | 
												<input type="button" value="글삭제하기" id="BDDelete" name="BDDelete">
												</td>
											</tr>	
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td><!--  style="border-collapse: collapse; -->
								<table id="BNWrite" width="900px" height="430px" style="border-collapse: collapse; border:0px; ">
									<colgroup>
											<col width="10%">
											<col width="20%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
											<col width="15%">
									</colgroup>
									<tbody>
										<tr height="40px" style="background:#9E9E9E; text-align: center;">
											<th style="font-size: 12px;">제목</th>
											<th style="font-size: 12px; text-align: center;" colspan="5"><%=bdvo.getBdsubject() %></th>
										</tr>
										<tr height="40px" style="background:#9E9E9E; text-align: center; font-size: 12px;">
<%
					String jobname = "";
					jobname = bdvo.getJobcd();
					jobname = ChangeName.jobcdName(jobname);
%>
											<th>작성자</th>
											<th><%=bdvo.getEmname() %> ( <%=jobname %> )</th>
											<th>작성일</th>
											<th><%=bdvo.getBdinsertdate() %></th>
											<th>수정일</th>
											<th><%=bdvo.getBdupdatedate() %></th>
										</tr>
										<tr>
											<th style="background:#9E9E9E; text-align: center; height:100px;" rowspan="2">내용</th>
											<th colspan="5" align="center" style="font-size: 12px; ">
											<img src="<%=bdvo.getBdfilepath() %>" />
											</th>
										</tr>
										<tr>
											<td colspan="6" height="200px" style="background:#F9FAF7;" ><%=bdvo.getBdcontent() %>
											</td>
										</tr>
										<tr height="10px">
											<td align="left" colspan="3">
												<input type="button" value="글쓰기" id="BDInsert" name="BDInsert"> : 
												<input type="button" value="답글" id="RefBInsert" name="RefBInsert">
											</td>
											<td align="right" colspan="3">
												<input type="button" value="목록으로 돌아가기" id="BDList" name="BDList">
											</td>
										</tr>
										<tr>
										<!-- 댓글 -->
											<jsp:include page="COM_BD.jsp"></jsp:include>
										<!-- 댓글 -->
										</tr>
									</tbody>
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