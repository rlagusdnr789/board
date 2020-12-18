<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $('#removeButton').click(function(){
        if($('#boardPw').val().length <4) {
            alert('boardPw는 4자이상 이어야 합니다');
            $('#boardPw').focus();
        } else {
            $('#removeForm').submit();
        }
    });
});
</script>
<title>BOARD REMOVE FORM</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	//boardNo값이 넘어오지 않으면 boardList.jsp로 이동
	if(request.getParameter("boardNo")== null){
		response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
	}else{
%>
	<div class="container p-3 my-3 bg-dark text-white">
	<form id="removeForm" action="<%=request.getContextPath()%>/jsp_board/boardRemoveAction.jsp" method="post">
		<!-- boardPw와 함께 boardNo값도 숨겨서(hidden값으로) 넘김 -->
		<input name="boardNo" value="<%=request.getParameter("boardNo") %>" type="hidden"/>
		<div>비밀번호확인 :</div>
		<div><input id="boardPw" name="boardPw" type="password"></div>
		<div>
             <input id="removeButton" type="button" value="삭제"/>
             <input type="reset" value="초기화"/>
        </div>
        </form>
		</div>
<%
	}
%>
</body>	
</html>