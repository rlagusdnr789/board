<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String boardPw = request.getParameter("boardPw");
	System.out.println("param boardPw:"+boardPw);
	String boardTitle = request.getParameter("boardTitle");
	System.out.println("param boardTitle:"+boardTitle);
	String boardContent = request.getParameter("boardContent");
	System.out.println("param boardContent:"+boardContent);
	String boardUser = request.getParameter("boardUser");
	System.out.println("param boardUser:"+boardUser);
	String dbUrl="jdbc:mriadb://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
	String dbUser="root";
	String dbPw="db암호";
	Connection connection = null;
	PreparedStatement statement = null;
	try{
		Class.forName("org.mariadb.jdbc.Driver");
		connection= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/board","root","java1004");
		String sql = "INSERT INTO board(board_pw,board_title,board_content,board_user,board_date)values(?,?,?,?,now())";
		statement = connection.prepareStatement(sql);
		statement.setString(1,boardPw);
		statement.setString(2,boardTitle);
		statement.setString(3,boardContent);
		statement.setString(4,boardUser);
		statement.executeUpdate(); //insert쿼리를 실행
		
	//쿼리 실행 후 boardList.jsp로 이동하는코드 -	boardList.jsp페이지를 만들지 않아서 주석처리 해둠  
	 response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
	
	}catch(Exception e){
		e.printStackTrace();
		out.print("입력 예외 발생");  response.sendRedirect(request.getContextPath()+"/jsp_board/boardAddForm.jsp");
    } finally {
    	try {statement.close();} catch(Exception e) {}
    	
    	
	}
%>
</body>
</html>