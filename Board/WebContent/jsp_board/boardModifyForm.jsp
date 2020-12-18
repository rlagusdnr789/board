<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#modifyButton').click(function(){
			if($('#boardPw').val().length<4){
				alert('비밀번호 4자 이상하세요');
				$('#boardPw').focus();
			}else if($('#boardTitle').val()==''){
				alert('title입력하시오');
			}else if($('#boardContent').val()==''){
				alert('boardContent입력하시오');
			}else if($('#boardUser').val()==''){
				alert('boardUser입력하시오');
			}else{
				$('#modifyForm').submit();
			}
			
			
			
		});
	});
	
	
</script>
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<h1>BOARD MODIFY</h1>
<% 
	if(request.getParameter("boardNo")==null){
		response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
	}else {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("boardModify param boardNo:"+boardNo);
		String boardTitle="";
		String boardContent="";
	
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		try{
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/board","root","java1004");	
			String selectSql="SELECT board_title,board_content FROM board WHERE board_no=?";
			statement = connection.prepareStatement(selectSql);
			statement.setInt(1,boardNo);
			resultSet= statement.executeQuery();
			if(resultSet.next()){
				boardTitle = resultSet.getString("board_title");
				boardContent = resultSet.getString("board_content");
			} else {
				response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
			
			}
			}catch(Exception e){
				e.printStackTrace();
				out.println("BOARD MODIFY FROM ERROR!");
		} finally {
			try{resultSet.close();} catch(Exception e){}
			try{statement.close();} catch(Exception e){}
			try{connection.close();} catch(Exception e){}
		}
      
%>
	
<form id="modifyForm" action="<%=request.getContextPath()%>/jsp_board/boardModifyAction.jsp" method="post">
	<div class="container p-3 my-3 bg-dark text-white">
	<div>boardNo</div>
	<div><input name="boardNo" value="<%=boardNo%>" type="text" readonly="readonly"/></div>
	<div>비밀번호확인: </div>
	<div><input name="boardPw" id="boardPw" type="password"/></div>
	<div>boardTitle :</div>
	<div><input name="boardTitle" value="<%=boardTitle%>" id="boardTitle" type="text"/></div>
	<div>boardContnent :</div>
	<div><textarea name="boardContent" id="boardContent" rows="5" cols="50"><%=boardContent%></textarea></div>
	<div>
			   <input id="modifyButton" type="button" value="글수정"/>
               <input type="reset" value="초기화"/>
    </div>
    </div>
</form>
<%
	}
%>
</body>
</html>