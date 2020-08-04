<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.ge.vo.BDVO"%>
<%@ page import="com.spring.ge.vo.EmInfoVO"%>
<%@ page import="com.spring.ge.common.ChangeName"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<% 
Object objInfo = session.getAttribute("eminfo");
EmInfoVO evo = null;
evo = new EmInfoVO();
evo = (EmInfoVO)objInfo;

Object obj = request.getAttribute("boardDepartmentDetail");
BDVO bdvo = null;
bdvo = new BDVO();
bdvo = (BDVO)obj;	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>����</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/boardDetail.css" />
		<script type="text/javascript" src="/js/clock.js"></script>
		<script type="text/javascript" src="/include/js/HuskyEZCreator.js" charset="EUC-KR"></script>
		<script type="text/javascript">
			var oEditors = [];
			$(function(){
				$('.mainframe .loader').hide();
				setInterval("dpTime()",0);
				
				nhn.husky.EZCreator.createInIFrame({
					 oAppRef: oEditors,
					 elPlaceHolder: "bdcontent",
					 sSkinURI: "/include/SmartEditor2Skin.html",
					 htParams : {
						 bUseToolBar : true,
						 bUseVerticalResize : true,
						 bUseModeChanger : true,
						 fOnBeforeUnload : function(){
							 
						 }
					 },
					 fOnAppLoad : function(){
						 oEditors.getById["bdcontent"].exec("PASTE_HTML", [ "" ]);
					 },
					 fCreator: "createSEditor2"
					});							
				
				/* �Խñ� ���� */
				$("#BDInsert").click(function(){
					var check = confirm("�� �������� ���� ���ο� \n�۾��� �������� �̵��Ͻðڽ��ϱ�?");
					if(!check){
						return;
					}
					loading();
					location.href="/board/bDWrite.ge";			
				});
				$("#BDList").click(function(){
					var check = confirm("�� �������� �������� \n����������� �̵��Ͻðڽ��ϱ�??");
					if(!check){
						return;
					}
					loading();
					location.href="/board/bDList.ge";			
				});
				
				$("#BDUpdate").click(function(){
					
					if(confirm("�����Ͻðڽ��ϱ�?")){
					oEditors.getById["bdcontent"].exec("UPDATE_CONTENTS_FIELD", []);
						
					$("#ge_main").attr({
						"method" : "POST",
						"action" : "/board/bDUdate.ge"
					});
					loading();
					$("#ge_main").submit();
						
					}
					
						
				});
				$("#BDDelete").click(function(){
					var confirmText = confirm("�������� �ʰ� \n�����Ͻðڽ��ϱ�?");
					if(confirmText == true){
						loading();
						$("#ge_main").attr("action","/board/bDDelete.ge").submit();
					}
				});
				
				$('#logout').click(function(){
					if(confirm('�α׾ƿ� �Ͻðڽ��ϱ�?')){
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
					alert("���� ������ �������� �ʽ��ϴ�.");
					return;
				}
				loading();
				$("#ge_main").attr("action","/board/bDList.ge").submit();	
			}
			function deptcdCheck2(check){
				var checkDept = check;
				var userDept = "<%=evo.getDeptcd() %>";
				if(checkDept != userDept){
					alert("���� ������ �������� �ʽ��ϴ�.");
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
		  th, td {
		    padding: 3px;
		  }
		  table {
		    width: 900px;
		  }
		
		</style>
	</head>
	<body>
		<div id="ge_menudiv">
			<div class="topinfo">
				<div class="myname"><%=evo.getEmname()%> �� �ȳ��ϼ���.</div>
				<div class="logout" id="logout">logout</div>
			</div><!-- <div class="topinfo"> -->
		</div><!-- <div id="ge_menudiv"> -->
		<div class="ge_maindiv">
			<div class="topmenu">
				<div class="p">
					<a href="/ea/gemain.ge">����</a>��
					<a href="/ea/eamain.ge">���� ����</a>��
					<a href="#">���ڸ���</a>��
					<a href="#">������</a>��
					<a href="/board/boardMain.ge" style="color:#615F8D">�μ��Խ���</a>��
					<a href="/board/calendar.ge">��������</a>��
					<a href="#">������</a>��
					<a href="/em/myPageInfo.ge">����������</a></div>
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
						<div class="menubtn"><div class="mbtneff"></div><a href="/board/bNList.ge" onclick="">��������</a></div>
						<br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(20); return false;">������ �Խ���</a></div>
						<a href="javascript:deptcdCheck2(20);" style="color: black">&nbsp;&nbsp;�������Խ���</a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(30); return false;">���������� �Խ���</a></div>
						<a href="javascript:deptcdCheck2(30);" style="color: black">&nbsp;&nbsp;�������Խ��� </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="#" onclick="deptcdCheck1(40); return false;">������ �Խ���</a></div>
						<a href="javascript:deptcdCheck2(40);" style="color: black">&nbsp;&nbsp;�������Խ��� </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div>
						<a href="#" onclick="deptcdCheck1(50); return false;">��������� �Խ���</a>
						</div>
						<a href="javascript:deptcdCheck2(50);" style="color: black">&nbsp;&nbsp;�������Խ��� </a><br><br>
						<div class="menubtn"><div class="mbtneff"></div><a href="/pjboard/pjBoardList.ge" onclick="">������Ʈ�Խ���</a></div>
						<div class="menubtn"><div class="mbtneff"></div><a href="/anmsBoard/anBoardList.ge" onclick="">�͸��Խ���</a></div>						
						<div class="clock" style="border:1px solid #000000; border-radius:1px; background:#808080; float:left; margin:10px 0 10px 0px; padding:5px 0 5px 0">
						<div align="center" style="font-size:20pt ;color:white; "class="dpTime" id="dpTime"></div>
						</div>						
					</div><!-- <div class="ge_sidemenu"> -->
					<div class="mainframe">
						<div id="noticebar" style="height:50px; width:10px; background:#999999; margin:20px 0px 0px 20px; float:left"></div>
						<div style="margin:20px; float:left; height:50px; width:400px; margin:20px 0px 0px 0px;"><h1>&nbsp;�����ϱ�</h1></div>
						<form name="ge_main" id="ge_main">
						<div style="margin:100px 0px 0px 20px; float:bottom">
						<table width="950px" style="margin:20px 0px 0px 10px; border-collapse: collapse; border:0px;">
							<tr>
								<td>
								<br>
								<br>
								<br>
									<table id="BDWrite" width="900px" height="430px" style="border-collapse: collapse; border:0px;">
										<colgroup>
											<col width="15%">
											<col width="35%">
											<col width="20%">
											<col width="20%">
										</colgroup>	
										<tr height="50px" style="background:#9E9E9E; text-align: center;">
											<th style="font-size: 18px; border:1px;">�ۼ���</th>
											<th style="font-size: 18px;"><%=bdvo.getEmname() %></th>
											<th style="font-size: 18px;">�μ�</th>
<%
											System.out.println("job" + bdvo.getJobcd());
											String jobname =  ChangeName.jobcdName(bdvo.getJobcd());
%>																				
											<th style="font-size: 18px;"><%=evo.getDeptname() %> ( <%=jobname %> )</th>
											
										</tr>
										<tr height="50x">
											<th style="background:#9E9E9E; text-align: center; font-size: 18px;">����
											<input type="hidden" id="bdno" name="bdno" value=<%=bdvo.getBdno() %>></th>
											<td>
												<input type="text" id="bdsubject" name="bdsubject" value="   <%=bdvo.getBdsubject() %>" style="width:100%; height:100%; border:0px;">
											</td>
											<th style="background:#9E9E9E; text-align: center; font-size: 18px;">�������μ���</th>
											<td>
												<select id="bdnoticeyn" name="bdnoticeyn" style="width:100%;">
					<%
											if(bdvo.getBdnoticeyn().equals("Y")){
					%>							
										    	<option value="Y">�μ���������</option>
										    	<option value="N"></option>	
					<%							
											}else{
					%>							
												<option value="N"></option>
										    	<option value="Y">�μ���������</option>							
					<%							
											}
					%>		    
												</select>
											</td>
											
										</tr>
										<tr height="300px">
											<th style="background:#9E9E9E; text-align: center; font-size: 18px;">����</th>
											<td colspan="3" style="width:100%; height:100%">
												<textarea name="bdcontent" id="bdcontent"
												rows="10" cols="100" style="width:100%; height:300px; color:#666666;" ><%=bdvo.getBdcontent() %></textarea>					
											</td>
										</tr>
										<tr height="50px">
											<td align="left">
												<div id="BDButton">
													<input type="button" value="�ۻ����ϱ�" id="BDDelete" name="BDDelete">
												</div>
											</td>
											<td colspan="3" align="right">
												<div id="BDButton">
													<input type="button" value="����" name="BDUpdate" id="BDUpdate">
													<input type="button" value="���" name="BDList" id="BDList">			
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
			GE Project �� ����� ���ʱ� ������� 459 (���ʵ�, ��Ϻ���)<br>
			TEL : 02-1234-5678 / FAX : 02-1234-5678<br>
			Copyright �� GE Project. All Rights Reserved.
			</div><!-- <div class="bottominfo"> -->
			</div><!-- <div class="bottom"> -->
		</div><!-- <div class="ge_maindiv"> -->
	</body>
</html>