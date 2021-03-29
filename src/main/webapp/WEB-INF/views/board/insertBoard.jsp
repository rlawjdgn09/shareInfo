
<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="container">
<div class="row">
         <div class="col-lg-12 col-md-12 mx-auto">
              <!-- Basic Form Inputs card start -->
              <div class="card">
                  <div class="card-header">
                      <h5>Basic Form Inputs</h5>
                      <span>Add class of <code>.form-control</code> with <code>&lt;input&gt;</code> tag</span>
                  </div>
                  <div class="col-lg-10 col-md-12 mx-auto">
                  <div class="card-block">
                      <form id="frmBoard" method="post">
                      	<br>
                      	  <div class="form-group row">
                              <label class="col-sm-2 col-form-label">카테고리</label>
                              <div class="col-sm-8">
                                  <select name="category" class="form-control">
                                      <option value="">Select One Value Only</option>
                                      <option value="A">Info</option>
                                      <option value="B">Tip</option>
                                  </select>
                              </div>
                          </div>
                      	 <div class="form-group row">
                              <label class="col-sm-2 col-form-label">제목</label>
                              <div class="col-sm-8">
                                  <input name="title" type="text" class="form-control" required>
                              </div>
                          </div>
                          <div class="form-group row">
                              <label class="col-sm-2 col-form-label">내용</label>
                              <div class="col-sm-8">
                                  <textarea name="contents" rows="5" cols="30" class="form-control" placeholder="Default textarea" required></textarea>
                              </div>
                          </div>
                          <div class="form-group row">
                              <label class="col-sm-2 col-form-label">첨부파일</label>
	                              <div class="col-sm-8" id="uploadDiv">
	                                  <input name="uploadFile" type="file" class="form-control" multiple>
	                              </div>
                              </div>
                         
                          <div class="form-group row">
                              <label class="col-sm-2 col-form-label">첨부 파일 목록</label>
	                              <div class='col-sm-8' id="uploadResult">
									<ul>
									
									</ul>                              
	                              </div>
                          </div>
                           <div class="form-group row">
                              <label class="col-sm-2 col-form-label">작성자</label>
                              <div class="col-sm-8">
                                  <input name="memberId" type="text" class="form-control" value="<sec:authentication property="principal.username"/>" readonly="readonly">
                                  
                              </div>
                          </div>
	                          
	                  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                       	<input type="button" id="insertBoard" class="btn btn-info waves-effect waves-light" value="글 작성"/><input type="reset"  class="btn btn-info waves-effect waves-light" value="초기화"/>
                     	 </form>
                     	 
                    	</div>
                          </div>
                          </div>
                      </div>
                  </div>
              </div>

     
              <!-- Basic Form Inputs card end -->
                                    
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});

	
	var frmBoard=$("#frmBoard");
	var cloneObj = $("#uploadDiv").clone();
	
	$("#insertBoard").on("click",function(e){
		e.preventDefault();
		
		var str="";
		
		$("#uploadResult ul li").each(function(i,obj){
			var jobj=$(obj);
			console.dir(jobj);
			
			
	   		str +="<input type='hidden' name='attachList["+ i +"].fileName' value='"+ jobj.data("filename") +"'>"
	       + "<input type='hidden' name='attachList["+ i +"].uuid' value='"+ jobj.data("uuid") +"'>"
	       + "<input type='hidden' name='attachList["+ i +"].uploadPath' value='"+ jobj.data("path") +"'>"
	       + "<input type='hidden' name='attachList["+ i +"].fileType' value='"+ jobj.data("type") +"'>";
	       
	  	
		});
		frmBoard.attr("action","/board/insertBoard");
		frmBoard.append(str).submit();
		
	})
	
	$("input[type='file']").change(function(e){

		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
	       
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
	       
		var url = "/uploadAjaxAction";
		
		$.ajax({
			url: url,
			processData: false, 
			contentType: false,
			data: formData,
			type: 'POST',
			dataType:'json',
			success: function(result){
				//console.log(result); 
				showUploadedFile(result); //업로드 결과 처리 함수 
			}
		}); //end $.ajax
	});
	
   var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)");
   var maxSize = 5242880; //5MB
   //업로드 크기 확인
   function checkExtension(fileName, fileSize) {
      if(fileSize >= maxSize) {
         alert("파일 사이즈초과 되었습니다.");
         return false;
      }
      if(regex.test(fileName)) {
         alert("해당 확장자 파일은 업로드 할 수 없습니다.");
         return false;
      }
      return true;
   }
   
   var uploadResult =$("#uploadResult ul");
   //업로드 파일 목록 보여주기
   function showUploadedFile(uploadResultArr){
	   var str="";
	   
	   $(uploadResultArr).each(function(i,obj){
		   if(!obj.fileType){
			   var fileCallPath= encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			   var fileLink =fileCallPath.replace(new RegExp(/\\/g),"/");
			   str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
			  	   +"	<div>"
			       +"		<a href='/download?fileName="+fileCallPath+"'>"+obj.fileName + "</a>"
				   +" 		<button data-file=\'"+fileCallPath+"\' data-type='file'><i class='fa fa open-card-option fa-times'></i></button>"
				   +"</div></li>";
			   
		   }
		   else{
			   var fileCallPath= encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			   
			   var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
			   
			   originPath = originPath.replace(new RegExp(/\\/g),"/");
			   
			   console.log(fileCallPath);
			   
			   str+= "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
			   		+"<img src='/display?fileName="+fileCallPath+"'<a>"+obj.fileName +"</a>"
			   		+"<button data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa open-card-option fa-times'></i></button>";
			   		
		   }
		   
	   });
	   uploadResult.append(str);
   }
   
   uploadResult.on("click","li button",function(e){
	  	console.log("click");
	   var targetFile = $(this).data("file");
	
	   var type=$(this).data("type");
	   console.log(targetFile);
	   console.log(type);
	   var targetLi = $(this).closest("li");
	   

	   $.ajax({
		   url:'/deleteFile',
		   data:{fileName:targetFile,type:type},
		  	dataType:'text',
		   type:'post',
		   success:function(result){
			  
			   targetLi.remove();
				return false;
		   }
	   })
   })
	
</script>
<%@include file="../includes/footer.jsp" %>