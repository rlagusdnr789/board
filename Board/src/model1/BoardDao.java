package model1;
 
import java.sql.*;
import java.util.ArrayList;
 
public class BoardDao { // Data Access Object
   //메서드 마다 드라이브 로딩과 Connection을 구하는 코드가 중복되어 하나의 메서드로 추출
    public Connection getConnection() throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        String dbUrl = "jdbc:mariadb://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/board","root","java1004");
        return connection;
    }
    //게시글 목록
    public ArrayList<Board> getBoardList(int currentPage, int pagePerRow){
    	ArrayList<Board> list = new ArrayList<Board>();
    	Connection connection = null; 	
    	PreparedStatement statement=null;
    	ResultSet rs = null;
    	try {
    		connection = this.getConnection();
    		String listSql = "SELECT board_no,board_title,board_user,board_date FROM board ORDER BY board_date DESC LIMIT ?,?";
    		statement = connection.prepareStatement(listSql);
    		statement.setInt(1,(currentPage-1)*pagePerRow);	
    		statement.setInt(2,pagePerRow);
    		rs = statement.executeQuery();
    		while(rs.next()) {
    			Board board= new Board();
    			board.setBoardNo(rs.getInt("board_no"));
    			board.setBoardTitle(rs.getString("board_title"));
    			board.setBoardUser(rs.getString("board_user"));
    			board.setBoardDate(rs.getString("board_date"));
    			list.add(board);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		System.out.print("예외발생");
    	} finally {
    		try {rs.close();} catch(Exception e) {}
    		try {statement.close();}catch(Exception e) {}
    		
    	}
    	return list;
    }
    
    // 전체 글 카운트
    public int getBoardCount() {
    	int count = 0;
    	Connection connection = null;
    	PreparedStatement statement= null;
    	ResultSet rs = null;
    	try {
    		connection = this.getConnection();
    		String totalSql = "SELECT COUNT(*) FROM board"; //board테이블의 전체행의 수를 반환
    		statement = connection.prepareStatement(totalSql);
    		rs = statement.executeQuery();
    		if(rs.next()) {
    			count = rs.getInt(1);
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
    		System.out.print("예외발생");
    	}finally {
    		try {rs.close();}catch(Exception e) {}
    		try {statement.close();}catch(Exception e) {}
    		try {connection.close();}catch(Exception e) {}	
    	}
    	return count;
    }
    
    //글쓰기 메서드
    public int insertBoard(Board board) {
        Connection connection = null;
        PreparedStatement statement = null;
        int row = 0;
        try {
        	connection = this.getConnection();
            String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
            statement = connection.prepareStatement(sql);
            statement.setString(1,board.getBoardPw());
            statement.setString(2,board.getBoardTitle());
            statement.setString(3,board.getBoardContent());
            statement.setString(4,board.getBoardUser());
            row = statement.executeUpdate(); // insert 쿼리를 실행
        } catch(Exception e) {
            e.printStackTrace();
            System.out.print("입력 예외 발생");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
        return row;
    }
        //boardView 
        //한개의 게시글 내용보기
        public Board getBoard(int boardNo) {
        	Board board = null;
        	Connection connection = null;
        	PreparedStatement statement = null;
        	ResultSet rs = null;
        	try {
        		connection = this.getConnection();
        		String sql = "SELECT board_title, board_content, board_user,board_date FROM board WHERE board_no=?";
        		statement = connection.prepareStatement(sql);
        		statement.setInt(1, boardNo);
        		rs = statement.executeQuery();
        		if(rs.next()) {
        			board = new Board();
        			board.setBoardNo(boardNo);
        			board.setBoardTitle(rs.getString("board_title"));
        			board.setBoardContent(rs.getString("board_content"));
        			board.setBoardUser(rs.getString("board_user"));
        			board.setBoardDate(rs.getString("board_date"));
        		}
        	}catch (Exception e) {
        		e.printStackTrace();
        		System.out.print("예외발생");
        	}finally {
        		try {rs.close();}catch(Exception e) {}
        		try {statement.close();}catch(Exception e) {}
        		try {connection.close();}catch(Exception e) {}
        }
        	return board;
    }
}
