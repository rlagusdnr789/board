<%@page import="model1.BoardDao"%>
<%@page import="java.sql.*" %>
<%@page import="model1.Board" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap을 사용하기 위한 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
	<h1>BOARD VIEW(모델1 방식)</h1>
<%
	int boardNo=0;
	Board board = null;
	if(request.getParameter("boardNo") == null){
        response.sendRedirect(request.getContextPath()+"/model1_board/boardList.jsp");
	}else{
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
		//System.out.println("boardNo :"+boardNo);
		BoardDao boardDao = new BoardDao();
        board = boardDao.getBoard(boardNo);
	}
%>	
	<table class="table">
		<tbody>
			<tr>	
				<td>board_no:</td>
				<td><%=board.getBoardNo()%></td>
			</tr>
			<tr>	
				<td>board_content:</td>
				<td><%=board.getBoardContent()%></td>
			</tr>
			<tr>	
				<td>board_user:</td>
				<td><%=board.getBoardUser()%></td>
			</tr>
			<tr>	
				<td>board_date:</td>
				<td><%=board.getBoardDate()%></td>
			</tr>
		</tbody>
	</table>
	<a class="btn btn-default" href="<%=request.getContextPath()%>/model1_board/boardModifyForm.jsp?boardNo=<%=boardNo%>">수정</a>
	<a class="btn btn-default" href="<%=request.getContextPath()%>/model1_board/boardRemoveForm.jsp?boardNo=<%=boardNo%>">삭제</a>
	<a class="btn btn-default" href="<%=request.getContextPath()%>/model1_board/boardList.jsp">글목록</a>
</div>
</body>
</html>