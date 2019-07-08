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
	
	RecommendDTO rec = new RecommendDTO();
	Map<String, Object> map = new HashMap<String, Object>();
	
	public Map<String, Object> recommend(int no, String recType, String likey, HttpSession session){
		Map<String, Object> data = new HashMap<String, Object>();
		String up = "up";
		String down = "down";
		
		// 우선 세션 로그인이 되어있는지 확인 후 안되어 있으면 return 
		String nickname = (String) session.getAttribute("nickname");
		if (nickname == null) {
			data.put("msg", "회원만 가능합니다.");
			return data;
		}
		
		// 닉네임이 어떤 글을 공감했는지  dto 가져오기
		map.put("nickname", nickname);
		map.put("no", no);
		map.put("recType", recType);
		map.put("likey", likey);
		
		RecommendDTO dto = recommend.selectRecommend(map);

		
		// 답변관련
		if(recType.equals("reply")) {	// 답변 좋아요	
			if(likey.equals("like")) {
				if(dto == null) {	
					map.put("upDown", up);

					recommend.insertNew(map);	// 새로 등록해줌
					reply.updateLikey(map);
				} else {			
					if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
						map.put("upDown", up);

						recommend.updateLikey(map);					//recommend like +1	
						reply.updateLikey(map);
					} else if(dto.getRec_like() == 1 && dto.getRec_dislike() == 0) {	// 좋아요는 한 상태라면 		
						map.put("upDown", down);
						
						recommend.updateLikey(map);				// recommend 종아요 -1
						reply.updateLikey(map);
					} else {
						data.put("msg", "이미 공감 하셨습니다.");
					}
				}
				return data;
			} else if (likey.equals("dislike")) {	// 답변 싫어요
				if(dto == null) {	
					map.put("upDown", down);

					recommend.insertNew(map);	// 새로 등록해줌
					reply.updateLikey(map);
				} else {			
					if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
						map.put("upDown", down);

						recommend.updateLikey(map);					//recommend like +1	
						reply.updateLikey(map);
					} else if(dto.getRec_like() == 0 && dto.getRec_dislike() == -1) {	// 좋아요는 한 상태라면 		
						map.put("upDown", up);
						
						recommend.updateLikey(map);				// recommend 종아요 -1
						reply.updateLikey(map);
					} else {
						data.put("msg", "이미 공감 하셨습니다.");
					}
				}
				return data;
			}
			
			// 답변관련 끝. 원글 관련 
		} else if(recType.equals("board")) {	
			if(likey.equals("like")) {
				if(dto == null) {	// 좋아요 or 싫어요 처음 눌렀을 때 recommend 테이블에 레코드가 없기 때문에 등록과 함께 recommned와 board 테이블에 해당글의 like 를 up 한다
					map.put("upDown", up);
					
					recommend.insertNew(map);			//글번호와 닉네임으로 가져온게 없을 때 like +1 하면서 레코드 등록
					board.updateLikey(map);			//해당 글에 대한 like +1 
				} else {			// 글번호와 닉네임을 가져온 값이 있을 때 실행되는 곳
					if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
						map.put("upDown", up);
						
						recommend.updateLikey(map);					//recommend like +1	
						board.updateLikey(map);						// board like +1
					} else if(dto.getRec_like() == 1 && dto.getRec_dislike() == 0) {	// 좋아요는 한 상태라면
						map.put("upDown", down);
						
						recommend.updateLikey(map);				// recommend 종아요 -1
						board.updateLikey(map);				// board 종하요 -1
					} else {
						data.put("msg", "이미 공감 하셨습니다.");
					}
				}
				
				return data;
			
			} else if (likey.equals("dislike")) {
				if(dto == null) {	// 좋아요 or 싫어요 처음 눌렀을 때 recommend 테이블에 레코드가 없기 때문에 등록과 함께 recommned와 board 테이블에 해당글의 like 를 up 한다
					map.put("upDown", down);
					
					recommend.insertNew(map);			//글번호와 닉네임으로 가져온게 없을 때 like +1 하면서 레코드 등록
					board.updateLikey(map);			//해당 글에 대한 like +1 
				} else {			// 글번호와 닉네임을 가져온 값이 있을 때 실행되는 곳
					if(dto.getRec_like() == 0 && dto.getRec_dislike() == 0) {	// 좋아요 or 싫어요가 둘 다 값이 없을 때 like + 1
						map.put("upDown", down);
						
						recommend.updateLikey(map);					//recommend like +1	
						board.updateLikey(map);						// board like +1
					} else if(dto.getRec_like() == 0 && dto.getRec_dislike() == -1) {	// 좋아요는 한 상태라면
						map.put("upDown", up);
						
						recommend.updateLikey(map);				// recommend 종아요 -1
						board.updateLikey(map);				// board 종하요 -1
					} else {
						data.put("msg", "이미 공감 하셨습니다.");
					}
				}
				return data;
				
			}
		}
		return null;
	}
	
}
