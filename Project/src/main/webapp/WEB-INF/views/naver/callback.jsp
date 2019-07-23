<%@page import="java.util.StringTokenizer"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버로그인</title>
</head>
<body>
	<%
	JSONParser parser = new JSONParser();
	JSONObject jsonObject;
	JSONArray jsonArray;
	
	String token = "";
	String nickname = "";
	String email = "";
	
	String getUrl = request.getRequestURL().toString();
	String[] currUrl = getUrl.split("/");
	String reUrl = currUrl[0] + "//" + currUrl[2] + "/" + currUrl[3] + "/naver/callback.do";
	
	System.out.println("reUrl = " + reUrl);

	
    String clientId = "j8R_N6PAsO7uCvkZDq3n";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "v8S57VjC2I";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode(reUrl, "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    System.out.println("apiURL="+apiURL);
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.print("responseCode="+responseCode);
      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
        jsonObject = (JSONObject) parser.parse(inputLine);
        System.out.println("\njsonObject = " + jsonObject);
        token = (String)jsonObject.get("access_token");
      }
      br.close();
      if(responseCode==200) {
        out.println(res.toString());
      }
    } catch (Exception e) {
      System.out.println(e);
    }
  
    String header = "Bearer " + token; // Bearer 다음에 공백 추가
    try {
        apiURL = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", header);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response1 = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response1.append(inputLine);
            System.out.println("inputLine = " + inputLine);
            jsonObject = (JSONObject) parser.parse(inputLine);		// 파싱해주면 유니코드 값이 변환 됨
            jsonObject = (JSONObject) jsonObject.get("response");	// response부분만 다시 jsonObject객체에 넣어줌
            email = (String)jsonObject.get("email");
            nickname = (String)jsonObject.get("email");			// response중에서 nickname만 가져옴
            System.out.println("nickname ======= "+ nickname);
            
            session.setAttribute("nickname", nickname);	//세션에 nickname 저장 
            session.setAttribute("email", email);	//세션에 nickname 저장 
   		
   			
   			String sendUrl = currUrl[0] + "//" + currUrl[2] + "/" + currUrl[3] + "/main.do";
   			
            response.sendRedirect(sendUrl);
            
        }
        br.close();
        System.out.println(response.toString());
    } catch (Exception e) {
        System.out.println(e);
    }
  %>
</body>
</html>