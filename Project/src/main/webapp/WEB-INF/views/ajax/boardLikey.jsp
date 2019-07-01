<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<tr>	
	<td align="center" id="likey" >
		<c:if test="${empty rec || rec.getRec_like() == 0 }">	<!-- rec(현재 글의 RecommendDTO) 없거나, 좋아요가 0 일때 -> 빈 엄지를 보여줌-->
			<a href="javascript:boardUpdateLike(${dto.getBoard_no()})">
				<img class="contentRec"  src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;&nbsp;
				<span class="boardUpdateLike" style="color: white">${dto.getBoard_like() }</span>&nbsp;&nbsp;&nbsp;
			</a>
		</c:if>

		<c:if test="${rec.getRec_like() == 1 }">
			<a href="javascript:boardUpdateLike(${dto.getBoard_no()})">
				<img class="contentRec"  src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;&nbsp;
				<span class="boardUpdateLike" style="color: white">${dto.getBoard_like() }</span>&nbsp;&nbsp;&nbsp;
			</a>
		</c:if>

		<c:if test="${empty rec || rec.getRec_dislike() == 0 }">
			<a href="javascript:boardUpdateDislike(${dto.getBoard_no()})">
				<img class="contentRec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;&nbsp;
				<span class="boardUpdateDislike" style="color: white">${dto.getBoard_dislike() }</span>
			</a>	
		</c:if>

		<c:if test="${rec.getRec_dislike() == -1 }">
			<a href="javascript:boardUpdateDislike(${dto.getBoard_no()})">
				<img class="contentRec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;&nbsp;			
				<span class="boardUpdateDislike" style="color: white">${dto.getBoard_dislike() }</span>
			</a>	
		</c:if>
	</td>
</tr>