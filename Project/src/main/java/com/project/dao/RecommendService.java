package com.project.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dto.RecommendDTO;

@Service
public class RecommendService {
	
	@Autowired
	private BoardDAOImpl board;
	
	@Autowired
	private ReplyDAOImpl reply;
	
	@Autowired
	private RecommendDAOImpl recommend;
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	public Map<String, Object> boardUpdateLike(int board_no, HttpSession session){
		Map<String, Object> msg = new HashMap<String, Object>();

		map.put("board_no", board_no);
		map.put("nickname", session.getAttribute("nickname"));

		RecommendDTO dto = recommend.selectFromBoard(map);
	
		if(dto == null) {	// 좋아요 or 싫어요 처음 눌렀을 때 recommend 테이블에 레코드가 없기 때문에 등록과 함께 recommned와 board 테이블에 해당글의 like 를 up 한다 
			recommend.insertBoardLikeUp(map);			//글번호와 닉네임으로 가져온게 없을 때 like +1 하면서 레코드 등록
			board.boardUpdateLike(board_no);			//해당 글에 대한 like +1 
		} else {			// 글번호와 닉네임을 가져온 값이 있을 때 실행되는 곳
			if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
				recommend.RecUpdateLikeUpBoard(map);					//recommend like +1	
				board.boardUpdateLike(board_no);						// board like +1
				
			} else if(dto.getRec_like() == 1 && dto.getRec_dislike() == 0) {	// 좋아요는 한 상태라면 		
				recommend.RecUpdateLikeDownBoard(map);				// recommend 종아요 -1
				board.boardUpdateLikeDown(board_no);				// board 종하요 -1
			} else {
				msg.put("msg", "이미 공감 하셨습니다.");
			}
		}
		return msg;
	}

	public Map<String, Object> boardUpdateDislike(int board_no, HttpSession session){
		Map<String, Object> msg = new HashMap<String, Object>();
		
		map.put("board_no", board_no);
		map.put("nickname", session.getAttribute("nickname"));
		
		RecommendDTO dto = recommend.selectFromBoard(map);
	
		if(dto == null) {	// 좋아요 or 싫어요 처음 눌렀을 때 recommend 테이블에 레코드가 없기 때문에 등록과 함께 recommned와 board 테이블에 해당글의 like 를 -1 한다 
			recommend.insertBoardLikeDown(map);			//글번호와 닉네임으로 가져온게 없을 때 like -1 하면서 레코드 등록
			board.boardUpdateDislike(board_no);			//해당 글에 대한 like -1 
		} else {			// 글번호와 닉네임을 가져온 값이 있을 때 실행되는 곳
			if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
				recommend.RecUpdateDislikeDownBoard(map);					//recommend like +1	
				board.boardUpdateDislike(board_no);						// board like +1
				
			} else if(dto.getRec_like() == 0 && dto.getRec_dislike() == -1) {	// 좋아요는 한 상태라면 		
				recommend.RecUpdateDislikeUpBoard(map);				// recommend 종아요 -1
				board.boardUpdateDislikeUp(board_no);				// board 종하요 -1
			} else {
				msg.put("msg", "이미 공감 하셨습니다.");
			}
		}
		return msg;
	}

	public Map<String, Object> replyUpdateLike(int reply_no, HttpSession session){
		Map<String, Object> msg = new HashMap<String, Object>();
		
		map.put("reply_no", reply_no);
		map.put("nickname", session.getAttribute("nickname"));
		
		RecommendDTO dto = recommend.selectFromReply(map);
		
		if(dto == null) {	
			recommend.insertReplyLikeUp(map);			
			reply.updateLike(reply_no);
		} else {			
			if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
				recommend.RecUpdateLikeUpReply(map);					//recommend like +1	
				reply.updateLike(reply_no);
			} else if(dto.getRec_like() == 1 && dto.getRec_dislike() == 0) {	// 좋아요는 한 상태라면 		
				recommend.RecUpdateLikeDownReply(map);				// recommend 종아요 -1
				reply.updateLikeDown(reply_no);
			} else {
				msg.put("msg", "이미 공감 하셨습니다.");
			}
		}
		return msg;
		
	}

	public Map<String, Object> replyUpdateDisike(int reply_no, HttpSession session){
		Map<String, Object> msg = new HashMap<String, Object>();
		
		map.put("reply_no", reply_no);
		map.put("nickname", session.getAttribute("nickname"));
		
		RecommendDTO dto = recommend.selectFromReply(map);
		
		if(dto == null) {	
			recommend.insertReplyLikeDown(map);			
			reply.updateDislike(reply_no);
		} else {			
			if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
				recommend.RecUpdateDislikeDownReply(map);					//recommend like +1	
				reply.updateDislike(reply_no);
			} else if(dto.getRec_like() == 0 && dto.getRec_dislike() == -1) {	// 좋아요는 한 상태라면 		
				recommend.RecUpdateDislikeUpReply(map);				// recommend 종아요 -1
				reply.updateDislikeUp(reply_no);
			} else {
				msg.put("msg", "이미 공감 하셨습니다.");
			}
		}
		return msg;
		
	}
}
