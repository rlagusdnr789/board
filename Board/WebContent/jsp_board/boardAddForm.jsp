<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
    $(document).ready(function(){
    //    alert('jquery test');
    /* 입력폼 유효성 관련 요구사항
        1. 모든 폼은 공백 또는 "" 문자는 입력되면 안된다.
        2. 비밀번호는 4자이상 입력하여야 한다.
    */
        $('#addButton').click(function(){
            if($('#boardPw').val().length <4) {
                alert('boardPw는 4자이상 이어야 합니다');
                $('#boardPw').focus();
            } else if($('#boardTitle').val()=='') {
                alert('boardTitle을 입력하세요');
                $('#boardTitle').focus();
            } else if($('#boardContent').val()=='') {
                alert('boardContent을 입력하세요');
                $('#boardContent').focus();
            } else if($('#boardUser').val()=='') {
                alert('boardUser을 입력하세요');
                $('#boardUser').focus();
            } else {
                $('#addForm').submit();
            }
        });
    });
</script>

<title>BOARD ADD</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>
	<div class="container p-3 my-3 bg-dark text-white">
	<h1>BOARD ADD</h1>
    	<form id="addForm" action="<%=request.getContextPath()%>/jsp_board/boardAddAction.jsp" method="post">
    <div>boardPw : </div>
    <div><input name="boardPw" id="boardPw" type="password"/></div>
    <div>boardTitle : </div>
    <div><input name="boardTitle" id="boardTitle" type="text"/></div>
    <div>boardContent : </div>
    <div><textarea name="boardContent" id="boardContent" rows="5" cols="50"></textarea></div>
    <div>boardName : </div>
    <div><input name="boardUser" id="boardUser" type="text"/></div>
    <div>
   <input id="addButton" type="button" value="글입력"/>
   <input type="reset" value="초기화"/>
    </div>
</form>
</div>
</body>
</html>