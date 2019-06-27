<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Portfolio Section -->
  <section class="page-section hotel" id="hotel">	<%-- menu bar에서 클릭하면 해당 id로 움직임 --%>
    <div class="container">

      <!-- Portfolio Section Heading -->
      <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">오늘 밤 어디가? >< </h2>

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

        <!-- Hohel Item 1 -->
        <div>            
            <form action="hotel.do">
            	<input name="hotel_search" placeholder="가고싶은 곳!!!">
            	<input type="submit" value="search">
            </form>
          
        </div>

      </div>

    </div>	<!-- class="container" -->
  </section>