<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$("#form").submit(functioin(){
		$.ajax({
			
		});
	})
</script>
</head>
<body>

	<jsp:include page="/resources/include/navigation.jsp" />
	
	<!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
	<div class="container d-flex align-items-center flex-column">
		<form id="form">
			<table>
				<tr>
					<td>name</td>
					<td><input name="name"></td>
				</tr>
	
				<tr>
					<td>pwd</td>
					<td><input name="pwd"></td>
				</tr>
				
				<tr><td colspan="2"><button id="submit">submit</button></td></tr>
			</table>
		</form>
		
		<div id="text">
		</div>			
	</div>
	</header>
	 
	 
	<jsp:include page="/resources/include/footer.jsp" />
	<jsp:include page="/resources/include/copyright.jsp" />
	<jsp:include page="/resources/include/modals.jsp" />

</body>
</html>