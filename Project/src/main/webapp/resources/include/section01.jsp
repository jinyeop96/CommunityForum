<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Portfolio Section -->
  <section class="page-section hotel section1" id="hotel">	<%-- menu bar에서 클릭하면 해당 id로 움직임 --%>
    <div class="container">

      <!-- Portfolio Section Heading -->
      <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">잠자고 총쏘자>.< </h2>

      <!-- Icon Divider -->
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
          <i class="fas fa-star"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>

      <!-- Portfolio Grid Items -->
      <div align="center" >


	<script>

function hotelCheck() {

	  if(fd.hotel_search.value == "") {

	    alert("찾고자 하는 지역명을 입력하세요!.");

	    fd.hotel_search.focus();

	    return false;

	  }
	  
	  else if(fd.hotel_search.value == "") {

		    alert("찾고자 하는 지역명을 입력하세요!.");

		    fd.hotel_search.focus();

		    return false;

		  }

		  else return true;

		}


</script>
	



        <div>            
            <form action="hotel.do" name="fd">
           	<input type="hidden" name="board_type" value="hotel">
            	<input style="width:200px;" class="input" name="hotel_search" placeholder='"양구군 남면 용하리"'>
            	<input type="submit" value="search" class="buttons" onclick="return hotelCheck()">
            </form>
          
        </div>

      </div>

    </div>	<!-- class="container" -->
  </section>