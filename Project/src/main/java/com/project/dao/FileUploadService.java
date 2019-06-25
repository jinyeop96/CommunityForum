package com.project.dao;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
//@Configurable - 비지니스 로직을 생성자에 넣고 싶다면 이렇게 해야함
public class FileUploadService {

	
	String uploadPath = "C:/gittest/0619_Project/Project/src/main/webapp/resources/uploadFiles";

	String uploadName;	// uploadPath + 날짜폴더명
	
	//이름 중복 안되게끔 랜덤 String 만들어줌
	UUID uuid = UUID.randomUUID();
	
	@Autowired
	public BoardDAOImpl board;
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	
	public void fileUpload(List<MultipartFile> files, int board_no){
		// 해당 날짜 폴더 생성
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);  int month = cal.get(Calendar.MONTH) + 1; int day = cal.get(Calendar.DAY_OF_MONTH);
		
		String date = year + "." + month + "." + day;
		
		// 저장위치 + 날짜폴터
		uploadPath += "/" + date;
		
		// 해당 위치에 해당 날짜폴더 없으면 만들기
		File createFile = new File(uploadPath);
		if(!createFile.exists()) {
			createFile.mkdirs();
		}

		for(MultipartFile multipartFile : files) {
			// 위의 uploadPath + 날짜폴더 만들 예정
			
			//------------------폴더 작업 끝------------------------------
			//------------------업로드 파일 작업 시작----------------
			
			// 중복x처리. -> 랜덤_파일이름.확장자
			uploadName = uuid.toString()+"_"+multipartFile.getOriginalFilename();
			
			
			//저장위치+날짜폴더 안에, 파일 올림
			File file = new File(uploadPath, uploadName);
			try {
				// 임시디렉토리에 저장된  파일을 uploadPath에 저장
				FileCopyUtils.copy(multipartFile.getBytes(), file);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			String DBName = "/" + date + "/" + uploadName;
			map.put("boardfile_name", DBName);
			map.put("board_no", board_no);
			
			board.insertFile(map);
		}
		
		
	}
	
}










