<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<h1>BOARD VIEW</h1>
<%
	if(request.getParameter("boardNo")==null){
		response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
	}else{
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("boardNo :" + boardNo);
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
    		Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/board","root","java1004");
			String sql = "SELECT board_title, board_content, board_user, board_date FROM board WHERE board_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1,boardNo);
			resultSet= statement.executeQuery();
			if(resultSet.next()){
%>				
				<div class="container p-3 my-3 bg-dark text-white">
				<div>board_no :</div>
				<div><%=boardNo%></div>
				<div>board_title :</div>
				<div><%=resultSet.getString("board_title")%></div>
				<div>board_content :</div>
				<div><%=resultSet.getString("board_content")%></div>
				<div>board_date :</div>
				<div><%=resultSet.getString("board_date")%></div>
		 
		 		<div>
                  <a class="btn btn-primary" href="<%=request.getContextPath()%>/jsp_board/boardModifyForm.jsp?boardNo=<%=boardNo%>">수정</a>
                  <a class="btn btn-primary" href="<%=request.getContextPath()%>/jsp_board/boardRemoveForm.jsp?boardNo=<%=boardNo%>">삭제</a>
                </div>
                </div>
			
<%		}
        }catch(Exception e) {
        	e.printStackTrace();
        	out.println("BOARD VIEW ERROR!");
	} finally{
		try{resultSet.close();} catch(Exception e){}
		try{statement.close();} catch(Exception e){}
		try{connection.close();} catch(Exception e){}
	}
	}
%>
</body>
</html>