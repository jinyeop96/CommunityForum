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

        <!-- Hohel Item 1 -->
        <div>            
            <form action="transportTest.do">
            	<input style="width:210px;" id="depart" name="transportTest1_search" placeholder="출발지를 입력하세요.">
            	<input style="width:210px;" id="arrival" name="transportTest2_search" placeholder="도착지를 입력하세요.">
            	<input id="search1" type="submit" value="search" >
            </form>
          
<script>
  $("#search1").click(function(){
    if($.trim($("#depart").val())==''){
      alert("입력해주세요.");
      return false;
    }  
    $("#next_form").submit();
  }); 
</script>

          
        </div>

      </div>

    </div>	<!-- class="container" -->
  </section>