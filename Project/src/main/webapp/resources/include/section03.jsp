<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Portfolio Section -->
  <section class="page-section transport section3" id="transport">	<%-- menu bar에서 클릭하면 해당 id로 움직임 --%>
    <div class="container">

      <!-- Portfolio Section Heading -->
      <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">집 갔다와서 총쏘자</h2>

      <!-- Icon Divider -->
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
          <i class="fas fa-star"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>

      <!-- Portfolio Grid Items -->
      <div align="center">

	<script>

function check() {

  if(fr.transportTest1_search.value == "") {

    alert("출발지와 도착지를 입력하세요!");

    fr.transportTest1_search.focus();

    return false;

  }

  else if(fr.transportTest2_search.value == "") {

    alert("출발지와 도착지를 입력하세요!");

    fr.transportTest2_search.focus();

    return false;
 
  } else if (!$("input[name='radio']").is(":checked")){
	  alert("교통 수단을 선택하세요!");
	  return false;
  }

  else return true;

}

</script>

        <!-- Hohel Item 1 -->
        <div>            
        
            <form action="transportTest.do" name="fr">
            	<input type="hidden" name="board_type" value="transportTest">
            	
            	<input type="radio" name="radio" value="0" >고속
	    		<input type="radio" name="radio" value="1" >시외
	    		<input type="radio" name="radio" value="2" >기차
	    	
	    		<br> 
            
            	<input type="text" style="width:100px;" id="depart" class="input" name="transportTest1_search" placeholder='출발터미널'>
            	<input type="text" style="width:100px;" id="arrival" class="input" name="transportTest2_search" placeholder='도착터미널'>
            	<input id="search1" type="submit" value="search" class="buttons" onclick="return check()">
            </form>
          
        </div>

      </div>

    </div>	<!-- class="container" -->
  </section>