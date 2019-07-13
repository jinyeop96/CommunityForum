<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Portfolio Section -->
  <section class="page-section" id="restaurant">	<%-- menu bar에서 클릭하면 해당 id로 움직임 --%>
    <div class="container" >

      <!-- Portfolio Section Heading -->
      <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">밥먹고 총쏘자 (^오^)</h2>

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

function readyCheck() {

	  if(fe.restaurant_search.value == "") {

	    alert("지역명과 음식점(맛집)을 입력하세요!");

	    fe.restaurant_search.focus();

	    return false;

	  }
	  
	  else if(fe.restaurant_search.value == "") {

		    alert("지역명과 음식점(맛집)을 입력하세요!");

		    fe.restaurant_search.focus();

		    return false;

		  }

		  else return true;

		}


</script>


        <div>            
            <form action="restaurant.do" name="fe">
                <input type="hidden" name="board_type" value="restaurant">
            	<input style="width:210px;" name="restaurant_search" placeholder="지역명+맛집(음식점)">
            	<input id="search" type="submit" value="search"  onclick="return readyCheck()">
            </form>
          
        </div>

      </div>

    </div>	<!-- class="container" -->
  </section>