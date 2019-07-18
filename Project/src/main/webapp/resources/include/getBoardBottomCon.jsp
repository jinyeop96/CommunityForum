<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>

<script>
	$(function(){
		console.log("${board_type}");
		boardBottomCon();
		
		//hotel.jsp 들어올때 기본적으로 댓글은 숨김
		$(".hide").hide();	//기본적으로 댓글 숨기기
		$(".modifies").hide();	//기본적으로 댓글 숨기기
		
	});
	
	
	// 수정/삭제 버튼 토글
	function showModifyBtn(num, reply_no){
		$(".modifyBtn"+num).toggle();	//기본적으로 댓글 숨기기
		$(".replyEditHide"+reply_no).hide();		//수정 입력란+index 만 toggle하기
	} 
	
	// 답변글 토글
	 function showReply(num){
		$(".reply"+num).toggle();
		$(".editHide").hide();		// 수정입력란 다 숨기기

	}	

	// 댓글 수정 입력란 보이게 하기
	function replyEdit(reply_no){
		$(".replyEditHide"+reply_no).toggle();		//수정 입력란+index 만 toggle하기
	}
		
	// 좋아요 싫어요
	function recommend(no, recType, likey, num, pageParam){
		$.ajax({
			url: "recommend.do",
			type:"post",
			data: {"no": no,
				   "recType": recType,
				   "likey": likey},
				   
			success:function(result){
				if(result.msg != null){
					alert(result.msg);
				}
				boardBottomCon(pageParam, 0);				
				$(".hide").hide();	 
				$(".modifies").hide();	//기본적으로 댓글 숨기기
				showReply(num);		
			},
			error:function(){
				alert("오류가 생겼습니다.");
			}
		});
	}
	
	function boardDelete(board_no, pageParam){
		if(confirm("게시글 삭제하시겠습니까?")){
			$.ajax({
				url:"boardDelete.do",
				type:"get",
				data: { "board_no": board_no,
						"board_type": "${board_type}"},
			 
				success:function(){
						boardBottomCon(pageParam, 0);				//다시 글 가져옴 (현재페이지, 0(무의미한 값));
						$(".hide").hide();							//기본적으로 댓글 숨기기 (새로가져오면서 원글 빼고 다 숨김)
						$(".modifies").hide();	//기본적으로 댓글 숨기기
						showReply(num);								//답변 수정한 원글 펼침 상태로
				}
			});
		}
	}
	
	function replyDelete(reply_no, num, pageParam){
		if(confirm("댓글 삭제하시겠습니까?")){
			$.ajax({
				url:"replyDelete.do",
				type:"get",
				data: { "reply_no": reply_no},
			 
				success:function(){
						boardBottomCon(pageParam, 0);				//다시 글 가져옴 (현재페이지, 0(무의미한 값));
						$(".hide").hide();							//기본적으로 댓글 숨기기 (새로가져오면서 원글 빼고 다 숨김)
						$(".modifies").hide();	//기본적으로 댓글 숨기기
						showReply(num);								//답변 수정한 원글 펼침 상태로
				}
			});
		}
	}
	function boardEdit(board_no, pageParam){
		location.href="boardEdit.do?board_no="+board_no+"&board_type=${board_type}&pageParam="+pageParam;
	}
	
	
	// 답변 수정			답변글번호, 각각의 글index, 댓글의 index, 현재 페이지
	function replyEditOk(reply_no,num, num2, pageParam){	
		$.ajax({
			url:"replyEditOk.do",
			type:"get",
			data: { "reply_no": reply_no,			//해당 원글 번호
					"reply_content": $("#reply_content_edit"+num2).val()},	//답글
		
			success:function(){
					$("#reply_content_edit"+num2).val("");		//댓글 수정입력란 초기화
					boardBottomCon(pageParam, 0);				//다시 글 가져옴 (현재페이지, 0(무의미한 값));
					$(".hide").hide();							//기본적으로 댓글 숨기기 (새로가져오면서 원글 빼고 다 숨김) 
					$(".modifies").hide();	//기본적으로 댓글 숨기기
					showReply(num);								//답변 수정한 원글 펼침 상태로
			}
		});
	};	//replyEditOk();
	
	// 답변 달기
	function reply(board_no, num, pageParam){	
		var nickname;
		if("${nickname}" != ""){
			nickname = "${nickname}";
		} else {
			nickname = "${admin}";
		}
		$.ajax({
			url:"replyUpdate.do",
			type:"get",
			data: { "board_no": board_no,			//해당 원글 번호
					"reply_content": $("#reply_content"+num).val(),	//답글
					"reply_nickname": nickname},
		
			success:function(result){	// result = pageParam
					$("#reply_content"+num).val("");
					boardBottomCon(pageParam, 0);
					$(".hide").hide();	//기본적으로 댓글 숨기기
					$(".modifies").hide();	//기본적으로 댓글 숨기기
					showReply(num);
					$("html, body").animate({scrollTop : $("#reply"+num).offset().top}, 400);
			}
		});
	};	//reply();
	
	
	// 지도 아래 게시물 가져오기
	function boardBottomCon(pageParam, checkPageUp){  
		if(pageParam == null){
			pageParam = 1;	//가장 처음 boardContent.jsp에 들어올 때는 board.jsp의 몇번째 페이지 였는지 알아야함. 안그러면 bottomBoard에는 무조건 page1으로 감.
		}
		if(checkPageUp == 1){	// 페이지 번호 누르면 checkPageUp이 넘어오는데 그때는  #map을 기준으로 올아래서 위로 올라옴
			$("html, body").animate({scrollTop : $("#map").offset().top}, 400);
		}
		
		$.ajax({
			url: "boardBottomCon.do",
			type:"post",
			async: false,
			data: {"pageParam": pageParam,
				   "board_type": "${board_type}"},
			success:function(result){
				$("#board").html(result).trigger("create");
				$(".hide").hide();	//기본적으로 댓글 숨기기
				$(".modifies").hide();	//기본적으로 댓글 숨기기
			}
		});
	};	
	
</script>

