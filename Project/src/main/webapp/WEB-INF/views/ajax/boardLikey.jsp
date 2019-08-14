<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

    
					<tr>	
		      			<td>
		      				<c:choose>
								<%-- 로그인 안했을때 --%>
								<c:when test="${empty boardRec }">
									<a href="javascript:recommend(${board_no}, 'board', 'like')" id="like2" class="no-deco">
					      				<img class="contentRec"  src="<c:url value='/resources/img/logos/up1.png'/>">&nbsp;&nbsp;&nbsp;
					      				<font class="boardUpdateLike" style="color: white; text-decoration: none;">${likes }</font>&nbsp;&nbsp;&nbsp;
				      				</a>
				      				
				      				<a href="javascript:recommend(${board_no}, 'board', 'dislike')" class="no-deco">
					      				<img class="contentRec" src="<c:url value='/resources/img/logos/down1.png'/>">&nbsp;&nbsp;&nbsp;
					      				<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dislikes }</font>
				      				</a>
								</c:when>
								
								<%-- 로그인 했을 때 --%>
								<c:when test="${!empty boardRec }">
									<a href="javascript:recommend(${board_no}, 'board', 'like')" id="like2" class="no-deco">
										<c:if test="${boardRec.getRec_like() == 1 }">	
											<img class="contentRec"  src="<c:url value='/resources/img/logos/up2.png'/>">&nbsp;&nbsp;&nbsp;
										</c:if>

										<c:if test="${boardRec.getRec_like() == 0 }">
											<img class="contentRec"  src="<c:url value='/resources/img/logos/up1.png'/>">&nbsp;&nbsp;&nbsp;
										</c:if>
										
										<font class="boardUpdateLike" style="color: white; text-decoration: none;">${likes }</font>&nbsp;&nbsp;&nbsp;
									</a>
				
									<a href="javascript:recommend(${board_no}, 'board', 'dislike')" class="no-deco">
										<c:if test="${boardRec.getRec_dislike() == 0 }">
											<img class="contentRec" src="<c:url value='/resources/img/logos/down1.png'/>">&nbsp;&nbsp;&nbsp;
										</c:if>
				
										<c:if test="${boardRec.getRec_dislike() == -1}">
											<img class="contentRec" src="<c:url value='/resources/img/logos/down2.png'/>">&nbsp;&nbsp;&nbsp;
										</c:if>
										<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dislikes }</font>
									</a>
								</c:when>
							</c:choose>
		      				<!-- <span id="likey"></span> --> 
		      			</td>
		      		</tr>