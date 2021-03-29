package org.spring5.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.spring5.domain.BoardAttachVO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	//해당 위치로 파일 업로드
	
	@PostMapping(value = "/uploadAjaxAction",
				produces = "application/json; charset = utf-8")
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile){
		List<BoardAttachVO> list = new ArrayList<>();
		String uploadFolder="C:\\upload";
		
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			BoardAttachVO boardAttachVO = new BoardAttachVO();
			
//			log.info("--------------------------------");
//			log.info(multipartFile.getOriginalFilename());
//			log.info(multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName=uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info(uploadFileName);
			boardAttachVO.setFileName(uploadFileName);
			//중복 방지 uuid 생성
			UUID uuid = UUID.randomUUID();
			
			uploadFileName= uuid.toString()+"_"+uploadFileName;
			
			
			try {
				File saveFile = new File(uploadPath,uploadFileName);
				multipartFile.transferTo(saveFile);
				
				boardAttachVO.setUuid(uuid.toString());
				boardAttachVO.setUploadPath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					
					boardAttachVO.setFileType(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				list.add(boardAttachVO);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	//년/월/일 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-",File.separator);
	}
	//이미지 파일 판단
	private boolean checkImageType(File file) {
		try {
			String contentType=Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//썸네일 처리
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		File file = new File("c:\\upload\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//img 파일 외 다운로드
	@GetMapping(value="/download",produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				downloadName=URLEncoder.encode(resourceName,"UTF-8").replaceAll("\\+", " ");
			}
			else if(userAgent.contains("Edge"))
			{
				downloadName=URLEncoder.encode(resourceName,"UTF-8");
			}
			else
			{
				downloadName = new String(resourceName.getBytes("UTF-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	//삭제 버튼시 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		File file;
		
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	
	
}
