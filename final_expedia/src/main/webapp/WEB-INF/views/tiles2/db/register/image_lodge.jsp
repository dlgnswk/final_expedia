<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/image_lodge.css" />

<title>숙박 시설 사진 등록</title>

<script type="text/javascript">
	let mainImage_arr = []; 	// 6 	메인이미지
	let outImage_arr = []; 		// 0	시설외부
	let publicImage_arr = []; 	// 1	공용구역
	let poolImage_arr = []; 	// 2	수영장
	let diningImage_arr = []; 	// 3	다이닝
	let serviceImage_arr = []; 	// 4	편의시설/서비스
	let viewImage_arr = []; 	// 5	전망

	$(document).ready(function(){
		
		// == mainImage메인이미지 Drag & Drop 만들기 == //
		$("div#mainImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(mainImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
		
	    
	 	// == outImage 시설외부 Drag & Drop 만들기 == //
		$("div#outImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(outImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
	    
	 	// == publicImage 공용구역 Drag & Drop 만들기 == //
		$("div#publicImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(publicImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
	    
	 	// == poolImage 수영장 Drag & Drop 만들기 == //
		$("div#poolImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(poolImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
	 	// == diningImage 다이닝장소 Drag & Drop 만들기 == //
		$("div#diningImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(diningImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
	 	// == serviceImage 고객서비스 Drag & Drop 만들기 == //
		$("div#serviceImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(serviceImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
	 	// == viewImage 전망 Drag & Drop 만들기 == //
		$("div#viewImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(viewImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
	    
	    
		// "사진 추가" 버튼 클릭시 input 파일을 클릭한 것으로 한다.		
		$("button.btnAdd").click(function(){
			$(this).next().click();
		});// end of $("button.btnAdd").click(function()
		
		// let mainImage_arr = []; 	// 6 	메인이미지
		// mainImage 메인이미지 "사진첨부" 
		$("input[name='mainImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(mainImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='mainImage']").change(function()
		
		
		
		// let outImage_arr = []; 		// 0	시설외부
		// outImage 시설외부 "사진첨부" 
		$("input[name='outImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(outImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='outImage']").change(function()
		

		
		// let publicImage_arr = []; 	// 1	공용구역
		// publicImage 공용구역 "사진첨부" 
		$("input[name='publicImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(publicImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='publicImage']").change(function()		
				

				
		// let poolImage_arr = []; 	// 2	수영장
		// poolImage 수영장 "사진첨부"
		$("input[name='poolImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(poolImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='poolImage']").change(function()		
				
		
		// let diningImage_arr = []; 	// 3	다이닝
		// diningImage 다이닝 "사진첨부"
		$("input[name='diningImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(diningImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='diningImage']").change(function()		
				
		
		// let serviceImage_arr = []; 	// 4	편의시설/서비스
		// serviceImage 편의시설/서비스 "사진첨부"
		$("input[name='serviceImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(serviceImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='serviceImage']").change(function()
				
				
		// let viewImage_arr = []; 	// 5	전망
		// viewImage_arr 전망 "사진첨부"
		$("input[name='viewImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(viewImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='viewImage']").change(function()
				
				
				
		// 이미지 삭제 버튼	
		$(document).on("click", "span.delete", function(){
			
			const delIdx = $(this).parent().parent().parent().find("span.delete").index($(this));
			const removeImg = $(this).parent().parent();
		//	console.log(delIdx);   0 1 2 3 4 5 ...
			
			const infoDiv = $(this).parent().parent().parent().find(".infoDiv");
			
		
			let arrName = $(this).parent().parent().parent();
		//	console.log("arrName => " + arrName.attr("id"));
			// arrName => diningImage
			// arrName => outImage
			
			let arrLength;
			
			// "x"버튼의 부모의 id를  찾아서 대응 시킨다.
			if ( arrName.attr("id") == "mainImage") {
			// let mainImage_arr = []; 	// 6 	메인이미지
				mainImage_arr.splice(delIdx,1);
				arrLength = mainImage_arr.length;
			}
			else if(arrName.attr("id") == "outImage" ) {
			// let outImage_arr = []; 		// 0	시설외부
				outImage_arr.splice(delIdx,1);
				arrLength = outImage_arr.length;
			}
			else if(arrName.attr("id") == "publicImage" ) {
			// let publicImage_arr = []; 	// 1	공용구역
				publicImage_arr.splice(delIdx,1);
				arrLength = publicImage_arr.length;
			}
			else if(arrName.attr("id") == "poolImage" ) {
			// let poolImage_arr = []; 	// 2	수영장
				poolImage_arr.splice(delIdx,1);
				arrLength = poolImage_arr.length;
			}
			else if(arrName.attr("id") == "diningImage" ) {
			// let diningImage_arr = []; 	// 3	다이닝
				diningImage_arr.splice(delIdx,1);
				arrLength = diningImage_arr.length;
			}
			else if(arrName.attr("id") == "serviceImage" ) {
			// let serviceImage_arr = []; 	// 4	편의시설/서비스
				serviceImage_arr.splice(delIdx,1);
				arrLength = serviceImage_arr.length;
			}
			else if(arrName.attr("id") == "viewImage" ) {
			// let viewImage_arr = []; 	// 5	전망
				viewImage_arr.splice(delIdx,1);
				arrLength = viewImage_arr.length;
			}
			
			if ( arrLength == 0 ) {
				infoDiv.show();
			}
			
			removeImg.remove(); // 이미지 제거하기
			
		}); // end of $(document).on("click", "span.delete", function()
		
				
				
		// 이미지 전체 삭제 버튼
		$("button.btnDelete").click(function(){
			
			const delId = $(this).parent().parent().parent().find("div.image_drop").attr("id");
			const removeImgs = $(this).parent().parent().parent().find("div.image_drop");
			
			// "x"버튼의 부모의 id를  찾아서 대응 시킨다.
			if ( delId == "mainImage") {
			// let mainImage_arr = []; 	// 6 	메인이미지
				mainImage_arr = [];
			}
			else if( delId == "outImage" ) {
			// let outImage_arr = []; 		// 0	시설외부
				outImage_arr = [];
			}
			else if( delId == "publicImage" ) {
			// let publicImage_arr = []; 	// 1	공용구역
				publicImage_arr = [];
			}
			else if( delId == "poolImage" ) {
			// let poolImage_arr = []; 	// 2	수영장
				poolImage_arr = [];
			}
			else if( delId == "diningImage" ) {
			// let diningImage_arr = []; 	// 3	다이닝
				diningImage_arr = [];
			}
			else if( delId == "serviceImage" ) {
			// let serviceImage_arr = []; 	// 4	편의시설/서비스
				serviceImage_arr = [];
			}
			else if( delId == "viewImage" ) {
			// let viewImage_arr = []; 	// 5	전망
				viewImage_arr = [];
			}
			removeImgs.find(".imageItem").remove(); // 이미지들 전부 지우기
			removeImgs.find(".infoDiv").show();		// "사진 업로드" 다시 보이기
			
		});// end of $("button.btnDelete").click(function()
				
				
		
				
				
	});// end of $(document).ready(function(){

	
	
	// 들어온 파일의 타입을 체크한다.
	function fileCheck(file) {
	
		const fileType = file[0].type; // 파일의 타입이 무엇인지 확인한다.
	//	console.log(typeof fileType); // image.png, image.jpeg
		
		let check = false; // 기본
			
		if( fileType.includes('jpeg') || fileType.includes('png') ) {
		// 파일 타입에 png, jpeg가 포함되어 있으면 이면 체크 true	
			check = true;
		}
		// png, jpeg포함되어 있지 않으면 false이다.
	//	console.log("check => "+ check);
		return check;
	} // end of function fileCheck(file)
	
	
	// "drop" 하는 이벤트 
	function arrDropPush(arr, files, elmt) {
		
		if(files != null && files != undefined){
			//	console.log("files.length 는 => " + files.length);
			
    		let html = "";
        	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
        	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
    	
    		if(fileSize >= 10) {
    			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
    			elmt.css("background-color", "#fff");
    			return;
    		}
    		else {
    		// 하나의 파일은 10MB를 넘지 못한다.
    		
    			if( arr == mainImage_arr && arr.length > 4 ) {
    				alert("메인 이미지는 최대 5개까지 가능합니다.");
    				return;
    			}
    			else {
    				
    				arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
	        		const fileName = f.name; // 파일명	
        			
                	const fileReader = new FileReader();
                	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
                	
                	let viewFileName = fileName;
		        //  console.log(fileName);
		            // 이그제큐티브 스위트 투베드룸1.png
				//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
		            // 이그제큐티브 스위트 투베드룸1
		        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
					// .png
                	
                	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
					const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
	              	// .png
	              	
		          	if( fileFrontName.length > 7) {
		          		console.log(fileFrontName);
		          		console.log(fileTypeName);
		          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
		          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
		          	}
                	
    				fileReader.onload = function(){
						/*
			              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
			              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
			          	*/
			          	
			          	html += 
			          		"<div class='imageItem'>" +
    		                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
    		                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
		               		"</div>";
	                    
	               		elmt.append(html);
                    	// document.getElementById("previewImg").src = fileReader.result;
	               		elmt.scrollLeft(99999999); // 스크롤 끝으로
    				}; // end of fileReader.onload = function() -----------
    				
    			}// end of if( mainImage_arr.length > 4 ) else -------
    		
			} // end of if(fileSize >= 10) else ---------- 파일은 10MB
    	
    	}// end of if(files != null && files != undefined)--------------------------
    
    	elmt.css("background-color", "#fff");		
	}// end of function arrDropPush(arr, files, elmt) ----------------------
	
	// "사진 추가" 하는 이벤트
	function arrPush(arr, files, elmt) {
		
		let html = "";
    	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
    	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
	
		if(fileSize >= 10) {
			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
			$(this).css("background-color", "#fff");
			return;
		}
		else {
		// 하나의 파일은 10MB를 넘지 못한다.
			// 메인 이미지의 경우
			if( arr == mainImage_arr && arr.length > 4 ) {
				alert("메인 이미지는 최대 5개까지 가능합니다.");
				return;
			}
			else {
				
				arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
        		const fileName = f.name; // 파일명	
    			
            	const fileReader = new FileReader();
            	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
            	
            	let viewFileName = fileName;
	        //  console.log(fileName);
	            // 이그제큐티브 스위트 투베드룸1.png
			//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
	            // 이그제큐티브 스위트 투베드룸1
	        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
				// .png
            	
            	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
				const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
              	// .png
              	
	          	if( fileFrontName.length > 7) {
	          		console.log(fileFrontName);
	          		console.log(fileTypeName);
	          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
	          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
	          	}
            	
				fileReader.onload = function(){
					/*
		              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
		              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
		          	*/
		          	
		          	html += 
		          		"<div class='imageItem'>" +
		                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
		                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
	               		"</div>";
                    
                	elmt.parent().parent().parent().find(".image_drop").append(html);
                	// document.getElementById("previewImg").src = fileReader.result;
                	elmt.parent().parent().parent().find(".image_drop").scrollLeft(99999999); // 스크롤 끝으로
				}; // end of fileReader.onload = function() -----------
				
				
			}// end of if( mainImage_arr.length > 4 ) else -------
		
		} // end of if(fileSize >= 10) else ---------- 파일은 10MB
	} // end of function arrLimitPush(arr, files, elmt) ------------------------------------- 이미지 5개 제한 
	
	
	
	// === 사진 등록 하기  === //
	$(document).on("click", "button#image_register", function(){
		
		var formData = new FormData($("form[name='addFrm']").get(0));
		
		// 메인 이미지 
		if(mainImage_arr.length > 0) {
			
			mainImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("mainImage_arr", item);  
	        });
			
		}// end of if(mainImage_arr.length > 0)
		
		// 시설외부
		if(outImage_arr.length > 0) {
			
			outImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("outImage_arr", item);  
	        });
			
		}// end of if(outImage_arr.length > 0)
		
		// 공용구역
		if(publicImage_arr.length > 0) {
			
			publicImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("publicImage_arr", item);  
	        });
			
		}// end of if(publicImage_arr.length > 0)
			
		// 수영장
		if(poolImage_arr.length > 0) {
			
			poolImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("poolImage_arr", item);  
	        });
			
		}// end of if(poolImage_arr.length > 0)
			
		// 다이닝
		if(diningImage_arr.length > 0) {
			
			diningImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("diningImage_arr", item);  
	        });
			
		}// end of if(diningImage_arr.length > 0)
			
		// 편의시설/서비스
		if(serviceImage_arr.length > 0) {
			
			serviceImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("serviceImage_arr", item);  
	        });
			
		}// end of if(serviceImage_arr.length > 0)
			
		// 전망
		if(viewImage_arr.length > 0) {
			
			viewImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("viewImage_arr", item);  
	        });
			
		}// end of if(viewImage_arr.length > 0)
		
		
		$.ajax({
            url : "<%= ctxPath%>/image_lodge.exp",
            type : "post",
            data : formData,
            processData:false,  // 파일 전송시 설정 -> query string(쿼리 스트링) 하지마라
            contentType:false,  // 파일 전송시 설정 
            dataType:"json",
            success:function(json){
          	  	
            	alert("이미지가 성공적으로 등록되었습니다.");
          	  	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
        });
		
	}); // end of $("button#image_register").click(function()
	
</script>


<div id="root_container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div class="container">
		<div class="title">
			<h2>숙박시설 이미지 등록</h2>
		</div>

		
		<div class="images_div">
			<span>메인이미지</span>
			<div class="image_drop __flex" id="mainImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="mainImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
		
		
		<div class="images_div">
			<span>시설외부</span>
			<div class="image_drop __flex" id="outImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="outImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
		
		<div class="images_div">
			<span>공용구역</span>
			<div class="image_drop __flex" id="publicImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="publicImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
		
		<div class="images_div">
			<span>수영장</span>
			<div class="image_drop __flex" id="poolImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="poolImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>

		<div class="images_div">
			<span>다이닝</span>
			<div class="image_drop __flex" id="diningImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="diningImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
		
		<div class="images_div">
			<span>편의시설/서비스</span>
			<div class="image_drop __flex" id="serviceImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="serviceImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
		
		<div class="images_div">
			<span>전망</span>
			<div class="image_drop __flex" id="viewImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="viewImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
			
		<form name="addFrm" enctype="multipart/form-data"></form>
		
		<div class="hadan">
			<button id="image_register" type="button">사진 등록</button>
		</div>
	</div>
</div>