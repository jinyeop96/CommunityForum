<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>

<script>
	$(function(){
		boardBottomCon();
	});
	function modifyBtnHide(){
		$(".modifies").hide();
	}
	
	// 게시글 + 댓글 보이기	
	function showContents(board_no, pageParam, scrollUp){
		if(pageParam == null){ var pageParam = 1; }
		$.ajax({
			url:"contentsCon.do",
			type: "post",
			data: {"board_no": board_no,
				   "pageParam": pageParam },
			success:function(result){
				$("#contentsCon"+board_no).html(result);
				$(".files").hide();
				modifyBtnHide();

			}
		});
		
		// 페이징 처리에서 다른 페이지 클릭했을 때만 작동
		if( scrollUp == 1){
			$("html, body").animate({scrollTop : $("#like"+board_no).offset().top}, 400);
		}
	}
	
	// 첨부파일 토글링
	function showFile(){
		$(".files").toggle();  
	}
	
	// 수정/삭제 버튼 토글
	// board	
	function showModifyBtn(no){
		$(".modifyBtn"+no).toggle();
	}
	
	// reply
	function showModifyBtn2(reply_no, board_no){
		var str = '<input type="button" onclick="replyEdit('+reply_no+", "+board_no+')" class="buttons" value="수정" style="float: right; margin-left: 10px"></input>'  +
				   '<input type="button" onclick="replyDelete('+reply_no+","+board_no+')" value="삭제" class="buttons" style="float: right"></input>';		
		$("#modifyBtn"+reply_no).html(str);
	} 
	 
 
	// 댓글 수정 입력란 보이게 하기
	function replyEdit(reply_no, board_no){
		var reply_content = $("#reply_content"+reply_no)["0"].textContent;
		var str = '<tr><td colspan="7"><textarea class="board resize-none textarea" rows="4"  placeholder="댓글 쓰기" id="reply_content_edit'+reply_no+'" >'+reply_content+'</textarea></td></tr>' +
				  '<tr><td colspan="7" align="right"><input type="button" onclick="replyEditOk('+reply_no+", "+board_no+')" class="buttons" value="저장"></td></tr>';
		$("#replies"+reply_no).hide();			//글 내용 숨기기
		$("#replyEdit"+reply_no).html(str);		//수정 입력란+index 만 toggle하기
	}
	
	// 답변 달기
	function reply(board_no){		//index는 게시글에 뿌리면서 붙여주는 임시 번호
		if("${nickname}" != ""){
			nickname = "${nickname}";
		} else {
			nickname = "${admin}";
		}
		
		$.ajax({
			url:"replyUpdate.do",
			type:"post",
			data: { "board_no": board_no,			//해당 원글 번호
					"reply_content": $("#replyContent"+board_no).val(),	//답글
					"reply_nickname": nickname},
		
			success:function(result){
					showContents(board_no); //댓글 저장하면 똑같은 글 다시 가져오기 해서 새로고침 해줌
			}
		});
	};	//reply();
	
		
	// 답변 수정			
	function replyEditOk(reply_no, board_no){	
		$.ajax({
			url:"replyEditOk.do",
			type:"post",
			data: { "reply_no": reply_no,			//해당 원글 번호
					"reply_content": $("#reply_content_edit"+reply_no).val()},	//답글
		
			success:function(){
				showContents(board_no); //댓글 저장하면 똑같은 글 다시 가져오기 해서 새로고침 해줌
			}
		});
	};	//replyEditOk();
	
	// 댓글 삭제
	function replyDelete(reply_no, board_no){
		if(confirm("댓글 삭제하시겠습니까?")){
			$.ajax({
				url:"replyDelete.do",
				type:"get",
				data: { "reply_no": reply_no},
			 
				success:function(){
					showContents(board_no); //댓글 저장하면 똑같은 글 다시 가져오기 해서 새로고침 해줌
				}
			});
		}
	}
	
	
	// 좋아요 싫어요
	function recommend(reply_no, board_no, recType, likey, pageParam){
		if(recType == "board"){	//게시글 에서 좋아요/싫어요 클릭 한거라면 no을 글번호로
			no = board_no;
		} else {				//댓글에서 한거면 no을 댓글번호로
			no = reply_no;
		}
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
				
				//글번호, 페이지 가지고 가서 새로 가져오기
				showContents(board_no, pageParam);
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
				}
			});
		}
	}
	
	
	function boardEdit(board_no, pageParam){
		location.href="boardEdit.do?board_no="+board_no+"&board_type=${board_type}&pageParam="+pageParam;
	}
	
	
	
	
	
	
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
				modifyBtnHide();
			}
		});
	};	
	
</script>


	<div align="center" class="board font-black">
		<table id="board" class="font-black board"></table>
	</div>

