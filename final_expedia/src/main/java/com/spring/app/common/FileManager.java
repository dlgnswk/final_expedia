package com.spring.app.common;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

// === #154. FileManager 클래스 생성하기 (파일을 올리는 기능이 여려곳에 존재하기 때문에 메소드로 만든다.) === //
@Component
public class FileManager {
	
	// == 파일 업로드 하기 첫번째 방법 ==
	// byte[] bytes : 파일의 내용물
	// String originalFilename : 첨부된 파일의 원래이름
	// String path : 업로드 할 파일의 저장경로
	// 리턴값 : 서버에 저장된 새로운 파일명(예: 20231124<년월일> 092915<시분초> 35243254235235234<나노타임> .png)
	// 						 ==> (예: 2023112409291535243254235235234.png)
	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
		
		String newFileName = null; // WAS(톰캣)의 디스크에 저장될 파일명
		
		if(bytes == null) {
			return null;
		}
		
		// 클라이언트가 업로드한 파일의 이름
		if("".equals(originalFilename) || originalFilename == null) {
			return null;
		}
		
		// 확장자(예:  강아지   또는   강아지.  또는   강아지.png   또는   강.아.지.png)
		// 강아지.       	==>  	originalFilename.lastIndexOf(".")  	==> 	3
		// 강아지.png   	==> 	originalFilename.lastIndexOf(".") 	==> 	3
		// 강.아.지.png 	==> 	originalFilename.lastIndexOf(".") 	==>	 	5
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || "".equals(fileExt) || ".".equals(fileExt) ) {
		// 확장자가 없는 경우 (잘못된 파일)
			return null;
		}
			
		// 서버에 저장할 새로운 파일명을 만든다.
		// 서버에 저장할 새로운 파일명이 동일한 파일명이 되지 않고 고유한 파일명이 되도록 하기 위해
		// 현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든다.
		newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFileName += System.nanoTime();
		newFileName += fileExt;
		// 2023112409291535243254235235234.png
		
		// 업로드할 경로가 존재하지 않는경우
		File dir = new File(path); // 만들어야 한다.
		// 파라미터로 입력받은 문자열인 path(파일을 저장할 경로)를 실제 폴더로 만든다.
		// 자바에서는 File 클래스를 사용하여 폴더 또는 파일을 생성 및 관리를 하게 된다.
		
		if(!dir.exists()) {
		// 만약 파일을 저장할 경로인 폴더가 실제로 존재하지 않는다면
			dir.mkdirs(); // 파일을 저장할 경로인 폴더를 생성한다.
		}
		
		String pathname = path+File.separator+newFileName;
		/* 		File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		*/
		// 해당경로에 \ 를 더하고 파일명을 더한 경로까지 나타내어준 파일명(문자열)을 만든다.
		// pathname => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files\2023112409291535243254235235234.png 이다.
		
		FileOutputStream fos = new FileOutputStream(pathname);
		// FileOutputStream 는 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 클래스 이다.
		// 이러한 일을 하는 FileOutputStream 객체 fos 를 생성한다.
		
		fos.write(bytes);
		// write(byte[] bytes) 메소드가 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 일을 하는 것이다.
		
		fos.close();
		// 생성된 FileOutputStream 객체 fos 가 더이상 사용되지 않도록 소멸 시킨다.
		
		// 파일을 업로드 한 이후에 
		// 업로드 되어진 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)을 알아온다.
		
		return newFileName;
	} // end of public String doFileUpload(byte[] bytes, String originalFilename, String path)

	
	// == 파일 다운로드 하기 ==
	// fileName : 서버에 저장된 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)
	// originalFileName : 클라이언트가 업로드한 파일명(파일명이 영어로 되어진 경우도 있지만 한글로 되어진 경우가 있다는 것에 유의하자)
	// path : 서버에 저장된 경로
	public boolean doFileDownload(String fileName, String originalFilename, String path, HttpServletResponse response) {
		String pathname = path + File.separator + fileName;
		// File.separator 은 운영체제에서 사용하는 파일경로의 구분자 이다.
        // 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
        // 운영체제가 UNIX 또는 Linux 이라면 File.separator 은 "/" 이다.
        // 해당경로에 \ 를 더하고 파일명을 더한 경로까지 나타내어준 파일명(문자열)을 만든다. 
		// pathname예) => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files\20231124113623422387038498900.pdf
		
		try {
		
			if(originalFilename == null || "".equals(originalFilename)) {
				originalFilename = fileName;
			}
		//	originalFileName = new String(originalFileName.getBytes("EUC-KR"), "8859_1" );
		//	또는	
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "8859_1" );
			// originalFilename.getBytes("UTF-8") 은 UTF-8 형태로 되어진 문자열 originalFilename 을 byte 형태로 변경한 후
	        // byte 형태로 되어진 것을 표준인 ISO-Latin1(혹은 Latin1 또는 8859_1) 형태로 인코딩한 문자열로 만든다.
		} catch (UnsupportedEncodingException e) {}
		
		File file = new File(pathname);
		// 다운로드 할 파일명(pathname)을 자기고 file객체와 한다.
		
		try {
			
		
		
		if(file.exists()) {// 실제로 다운로드할 해당 파일이 존재한다면
			
			response.setContentType("application/octet-stream");
            // 다운로드할 파일의 종류에 따라 Content-Type 을 지정해주어야 한다.
			// 이미지는 "image/jpeg" 같은 형식으로, 비디오는 "video/mpeg" 형식으로
			// 기타 인코딩된 모든 파일들은 "application/octet-stream" 으로 지정해주어야 한다.
			// 여기서는 모든 파일을 다운로드할 것이므로 기본값인 "application/octet-stream" 으로 지정해준다. 
            
            response.setHeader("Content-disposition",
                                "attachment; filename=" + originalFilename);
            // "Content-Disposition" 속성을 이용하여 해당 패킷이 어떤 형식의 데이터인지 알 수 있게 해주어야 한다.
            // 즉, 여기서 하는 작업의 내용물은 파일이 첨부된 것이므로 "attachment"로 설정하고 있다. 
            // 이는 첨부파일을 의미하며, 첨부된 파일명을 알려주어야 한다. 
      
            byte[] readByte = new byte[4096];
            // 다운로드할 파일의 내용을 읽어오는 단위크기를 4096 byte로 하는 byte 배열 readByte 를 생성한다. 
            
            BufferedInputStream bfin = new BufferedInputStream(new FileInputStream(file)); 
             // 클라이언트가 다운로드 해야 할 파일(file)을 읽어들이기 위해 new FileInputStream(file) 을 생성함. 
            // 또한 빠르게 읽어들이기 위해서 필터스트림(보조스트림) BufferedInputStream bfin 을 장착함. 
            
            ServletOutputStream souts = response.getOutputStream();
            // ServletOutputStream 은 다운로드 되어질 파일을 클라이언트로 보내어주는 출력 스트림용 클래스이다. 
            
            int length = 0;
            
            while( (length = bfin.read(readByte, 0, 4096)) != -1  ) {
            /*
                bfin.read(readByte, 0, 4096) 은 
                    다운로드 해주어야할 file에서 0(처음) 부터 4096 byte 만큼 읽어들인 후 
                readByte 라는 변수에 읽어들인 내용을 저장시킨다.
                   그런데 다운로드 해주어야할 file에서 읽어들인 내용이 없다라면 bfin.read(readByte, 0, 4096) 은 -1 을 리턴시켜준다. 
                   그러므로  while( (length = bfin.read(readByte, 0, 4096)) != -1  ) 말은 
                   다운로드 해주어야할 file 을 매번 4096 byte 씩 읽어들인다는 말이다.         
             */
               
               souts.write(readByte, 0, length);
               /*
               readByte 에 저장된 내용을 처음부터 읽어온 크기인 length 만큼  
               ServletOutputStream souts 에 기록(저장)해둔다.
                */
            }// end of while()----------------------------------
         
            souts.flush(); // ServletOutputStream souts 에 기록(저장)해둔 내용을 클라이언트로 내본다. 
         
            souts.close(); // ServletOutputStream souts 객체를 소멸시킨다.
            bfin.close();  // BufferedInputStream bfin 객체를 소멸시킨다.
            
            return true; // 다운로드 해줄 파일이 존재하고 Exception 이 발생하지 않으면 true 를 리턴시킨다. 
			
		}// end of if(file.exists())--------------
		
		} catch (Exception e) {}
		
		return false;
	} // end of public boolean doFileDownload(String fileName, String originalFileName, String path, HttpServletResponse response)

	
	// === 파일 삭제하기 == //
	public void doFileDelete(String fileName, String path) {

		String pathname = path + File.separator + fileName;
		File file = new File(pathname);
		
		if(file.exists()) {
			file.delete();
		}
	}// end of public void doFileDelete(String path, String fileName)
	
	
	// == 파일 업로드 하기 두번째 방법(네이버 스마트 에디터를 사용한 사진첨부에 해당하는 것임) ==
	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
	      
		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null || originalFilename.equals(""))
	         return null;
	      
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
	      
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
	      
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
	      
		String pathname = path + File.separator + newFilename;
	      
		byte[] byteArr = new byte[1024];
		int size = 0;
		FileOutputStream fos = new FileOutputStream(pathname);
	      	
		while((size = is.read(byteArr)) != -1) {
			fos.write(byteArr, 0, size);
		}
		fos.flush();
	      
		fos.close();
		is.close();
	      
		return newFilename;
	} // end of public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception --- 
	
	
	
	/*   
	   	스마트에디터로 textarea 에 글을 쓸 때 사진 첨부 시 해당 사진의 원본 크기로 출력되는 현상이 발생하였다.
	   	사진 사이즈 조절이 필요해서 SmartEditor 내에서 사이즈 조절 레이어가 나타나게끔 구현하고자 한다. 
	   	https://joorang.tistory.com/10 
	   	사이트를 참조 하면 잘 된다.
	 */
	// 이미지 폭
	public int getImageWidth(String pathname) {
	      
		int width = -1;
	      
		File file = new File(pathname);
	      
		if (! file.exists())
			return width;
	      
		ParameterBlock pb=new ParameterBlock(); 
		pb.add(pathname); 
	       
		RenderedOp rOp=JAI.create("fileload",pb); 

		BufferedImage bi=rOp.getAsBufferedImage(); 

		width = bi.getWidth();       
	      
		return width;
	}
	      
	   // 이미지 높이
	public int getImageHeight(String pathname) {
	      
		int height = -1;
	      
		File file = new File(pathname);
	        
		if (! file.exists())
	         return height;
	      
		ParameterBlock pb=new ParameterBlock(); 
		pb.add(pathname); 
	       
		RenderedOp rOp=JAI.create("fileload",pb); 

		BufferedImage bi=rOp.getAsBufferedImage(); 

		height = bi.getHeight();      
	      
		return height;
	} // end of getImageWidth(String pathname) -----------
	
	
	
	
	// == 숙박시설 이미지 등록 == // 
	public Map<String,String> imageUpload(MultipartFile imageFile, String path) throws Exception {
		Map<String,String> resultMap = new HashMap<>(); 
		
		String img_name = imageFile.getOriginalFilename();
		resultMap.put("img_name", img_name);
	//	System.out.println("img_name => "+ img_name);
		// img_name => 디럭스 신관1.png
		// img_name => 디럭스 신관3.png
		
		try {
			byte[] bytes = imageFile.getBytes();
            // 첨부파일의 내용물을 읽어오는 것
			
            String fileExt = img_name.substring(img_name.lastIndexOf("."));
            
            String img_save_name = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
            img_save_name += System.nanoTime();
            img_save_name += fileExt;
            
            resultMap.put("img_save_name", img_save_name);
       //   System.out.println("img_save_name => "+ img_save_name);
            // img_save_name => 202312221653101413015228395100.png
            // img_save_name => 202312221653101413015231578600.png
            
            String pathname = path+File.separator+img_save_name;
            
            FileOutputStream fos = new FileOutputStream(pathname);
            
            fos.write(bytes);
            
            fos.close();
            
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	} // 숙박 시설 이미지 등록 //
	
	
}
