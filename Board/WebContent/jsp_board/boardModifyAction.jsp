	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	if(request.getParameter("boardNo")== null || request.getParameter("boardPw") == null) {
		response.sendRedirect(request.getContextPath()+"jsp_board/boardList.jsp");
	} else {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("boardModifyACtion param boardNo :" +boardNo);
		String boardPw = request.getParameter("boardPw");
		System.out.println("boardModifyACtion param boardPw :" +boardPw);
		String boardTitle  = request.getParameter("boardTitle");
		System.out.println("boardModifyACtion param boardTitle  :" +boardTitle );
		String boardContent  = request.getParameter("boardContent");
		System.out.println("boardModifyACtion param boardContent  :" +boardContent );
		
		String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
        PreparedStatement statement = null;
        try{
        	Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/board","root","java1004");	
			   String selectSql = "UPDATE board SET board_title=?, board_content=? WHERE board_no=? AND board_pw=?";
	            statement = connection.prepareStatement(selectSql);
	            statement.setString(1, boardTitle);
	            statement.setString(2, boardContent);
	            statement.setInt(3, boardNo);
	            statement.setString(4, boardPw);
	            statement.executeUpdate();
	            response.sendRedirect(request.getContextPath()+"/jsp_board/boardView.jsp?boardNo="+boardNo);
	        } catch(Exception e) {
	            e.printStackTrace();
	            out.print("BOARD MODIFY ERROR!");
	        } finally {
	            try {statement.close();} catch(Exception e){}
	            try {connection.close();} catch(Exception e){}
	        }
	    }
	%>
