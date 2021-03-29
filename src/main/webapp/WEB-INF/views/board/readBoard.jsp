
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <style>
   .uploadImage img {
      height:450px;
      width:100%;
      margin: 0px auto;
      display:block;
      object-fit: scale-down; 
   }
   
   /* 이미지 섬네일  */
   .imgListWrapper {
       overflow:auto;
      border : 5px solid #cececc;
      border-radius: 5px;
   }
   
   .imgList {
      height: 80px;
      width : 100%;
       text-align: center;
   }
   
   .imgList span {
      position: relative;
      white-space: nowrap;
      display:inline;
      align-items:center;
   }
   
   .imgList img {
      height:80px;
      width:100px;
      object-fit: scale-down; 
      border : 1px solid gray;
      margin:0 auto;
      display:inline;
   }
   
	.download:hover {
		cursor: pointer;
		color : #00aeef;
	}
   
   
   
/* 중복 : 하나만 옮기기 */   
   /* 섬네일 스크롤 */
   ::-webkit-scrollbar { width: 5.2px; } /* 스크롤 바 */
   ::-webkit-scrollbar-track { background-color:#fff; } /* 스크롤 바 밑의 배경 */
   ::-webkit-scrollbar-thumb { background: #ddd; border-radius: 10px; } /* 실질적 스크롤 바 */
   ::-webkit-scrollbar-thumb:hover { background: #404040; } /* 실질적 스크롤 바 위에 마우스를 올려다 둘 때 */
   ::-webkit-scrollbar-thumb:active { background: #808080; } /* 실질적 스크롤 바를 클릭할 때 */
   ::-webkit-scrollbar-button { display: none; } /* 스크롤 바 상 하단 버튼 */
   
   .btnCustom
	{
	    font-size: 14px;
	    font-weight: 800;
	   
	    letter-spacing: 1px;
	    text-transform: uppercase;
	    border-radius: 0;
	    font-family: 'Open Sans','Helvetica Neue',Helvetica,Arial,sans-serif;
	}
 </style>
 
 
<div class="pcoded-inner-content">
     <div class="main-body">
         <div class="page-wrapper">
             <div class="page-body">
                 <div class="row">
                     <div class="col-lg-10 col-md-10 mx-auto">
                         <div class="card">
                             <div class="card-header">
                                 <h5>${board.title}</h5>
                                 <span>등록자:${board.memberId}</span>
                                 
                             </div>
                             <div class="card-block">
                               <!-- 원본 이미지  -->
									<div class="uploadImageWrapper" >
									   <div class="uploadImage">
									   </div>
									</div>
									 
									<!-- 썸네일 -->
									<div class="imgListWrapper">
									   <div class="imgList" id="imgList">
									   </div>
									</div>
									<!-- 이미지 끝  --> 							
																
								<div class="post-content overflow">
																	
																	
													                        
										<!-- 첨부파일 표시  210309-->
										<div class="attach">
										   <i class="fa fa-paperclip"> 첨부파일</i>
										   <div class="field-toggle-clip" style="display: none;">
										      <div class="uploadRead">
										         <ul>
										         </ul>
										      </div>
										   </div>
										</div>
									<!-- 첨부파일 끝-->		                        
					   	  </div>
					   	  <div>
					   	  	${board.contents}
					   	  </div>
                             <div class="card-header" >
                                <span id="writeDate"></span>
                                 <span id="updateDate"></span>
                                 <span>조회수:${board.countView}</span>
                             </div>
                         </div>
                         <div class="dropdown-primary dropdown open">
	                          <sec:authentication property="principal" var="pinfo" />
	                               <sec:authorize access="isAuthenticated()">
		                                <c:if test="${pinfo.username eq board.memberId}">	
	                               			 <button class="btn btn-primary dropdown-toggle waves-effect waves-light " type="button" id="dropdown-2" data-toggle="dropdown" aria-haspopup="false" aria-expanded="true">관리</button>
	                              			 <div class="dropdown-menu" aria-labelledby="dropdown-2" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 44px, 0px); top: 0px; left: 0px; will-change: transform;">
		                                    <a class="dropdown-item waves-light waves-effect" data-oper="modify">수정하기</a>
		                                    <a class="dropdown-item waves-light waves-effect" data-oper="remove">삭제하기</a>
		                               </div>	
		                              </c:if>
                               </sec:authorize>
                               <button class="btn waves-effect waves-light btn-primary" id="list"><i class="icofont icofont-user-alt-3"></i>목록</button>
                            </div>
                            <form id="operForm" action="/board/boardModify" method="get">
                           		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
								<input type="hidden" id='memberId' name='memberId' value='<c:out value="${board.memberId}"/>'>
								<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
								<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
								
							</form>
                      </div>
			      </div>
             </div>
             <div class="row">
                     <div class="col-lg-10 col-md-10 mx-auto">
                         <div class="card">
                             <div class="card-header">
                                 <h5>댓글</h5>
                              </div>
                             <sec:authorize access="isAuthenticated()">
                             <div class="card-block">
                                 <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">댓글 내용</label>
		                              <div class="col-md-8">
		                                  <textarea name="replyContent" id="replyContent" rows="2" cols="60"  placeholder="댓글 입력하시오"></textarea>
		                                   <button class="btnCustom waves-effect waves-light btn-primary" id="insertReply"><i class="icofont icofont-user-alt-3"></i>댓글 작성</button>
		                              </div>
                         		 </div>  	             
					   	 	 </div>
					   	 	 </sec:authorize>
					   	 	  <div class="row">
							      <div class="col-lg-8 col-md-10 mx-auto" id="replyList">
							       <hr>
							     </div>
    						</div>
    						<div class="row">
	    						<div class="reply-panel-footer">
								</div>
    						</div>
			      </div>
             </div>
         </div>
     </div>
 </div>
 </div>
<script src="/resources/js/board.js"></script>
<script src="/resources/js/reply.js"></script>
<script>
	var replyer = null;
	
	//시큐리티
	<sec:authorize access="isAuthenticated()">
		replyer='<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";


	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});

	var writeDate="${board.writeDate}";
	$("#writeDate").html("등록 일자: "+boardService.showTime(writeDate));
	var updateDate="${board.updateDate}";
	$("#updateDate").html("수정 일자: "+boardService.showTime(updateDate));
	
	var operForm=$("#operForm");
	
	$("a[data-oper='modify']").on("click",function(e){
		
		operForm.attr("action","/board/modifyBoard").submit();
	});
	
	$("a[data-oper='remove']").on("click",function(e){
		operForm.attr("method","post");
		operForm.attr("action","/board/removeBoard").submit();
	});
	
	$("#list").on("click",function(){
		operForm.find("input[name=bno]").remove();
		operForm.attr("action","/board/getBoardList").submit();
	})
	
	var bnoValue = '<c:out value="${board.bno}" />';
	   
	// 첨부파일표시 (이미지표시 & 파일표시)
	$.ajax({
		url: '/board/getAttachList',
		data: {bno: bnoValue},
		dataType: 'json',
		type: 'GET',
		success: function(arr) {
			console.log(arr);         
			var imgListStr="";
			var fileStr="";
         
			$(arr).each(function(i, attach) {
				//console.log(arr.length);
				if(attach.fileType == 1) {
	               var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
	                 
	               imgListStr += "<span> <img src='/display?fileName=" + fileCallPath + "' > </span>";
	               $(".imgListWrapper div").html(imgListStr);
	               
	               $(".uploadImageWrapper div").html("<img src='/display?fileName=" + fileCallPath + "' >");
	            
	            } else {
	               fileStr +="<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'"
	                     + "    data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' class='download'>"
	                     + "      <div>"
	                     //+ "         <img src='"+contextPath+"/resources/images/attach.png'>"
	                     + "         <span> ▶ "+ attach.fileName+"</span><br>"
	                     + "      </div>"
	                     + "</li>";
	               $(".uploadRead ul").html(fileStr);
	            }
	            
	            
         	});
			
			if (fileStr == ""){
	               $(".attach").hide();
	               
	        }
	            
            if (imgListStr == "") {
               $(".uploadImageWrapper").hide();
               $(".imgListWrapper").hide();
            }
			
      } // end success
   });
   
	//이미지표시
	   $("#imgList").on("mouseover", "img" ,function () {
	      $(this).attr("class", "originImg")
	      $(this).css("background-color","#efefed");
	      
	      
	      $(".uploadImageWrapper div img").remove();
	      $(this).clone().appendTo($(".uploadImageWrapper div"));
	      
	      
	      $("#imgList").on("mouseleave", "img" ,function () {
	         $(this).css("background-color","white");
	      });
	   });
	   
   
   
	// 첨부파일 목록 펼치기
	$('.fa-paperclip').on('click', function() {
	   $('.field-toggle-clip').fadeToggle(200);
	});
   
   // 첨부파일 다운로드
   $(".uploadRead").on("click", "li", function(e) {
      var liObj = $(this);
      var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
      
      self.location = "/download?fileName=" + path;
   });
  
   var replyUL = $("#replyList");
   var pageNum = 1;

   
   //댓글 1페이지 부터 조회
   showReplyList(1);
   
   function showReplyList(page){
	   replyService.getReplyList({bno:bnoValue,page:page||1},function(replyTotal,list){
		 if(page==-1)
		 {
			 pageNum = Math.ceil(replyTotal/10.0);
			 showReplyList(pageNum);
			 return;
		 }
		 
		 var replyStr="";
		 var result=false;
		 if(list==null|| list.length==0){
			 replyUL.html("");
			 return;
		 }
		
		 for(var i=0, len=list.length||0;i<len;i++){
			 console.log("id= "+list[i].memberId);
	         console.log("replyer: "+replyer);
	     	 
	     	 result=(replyer==list[i].memberId);
	     	console.log("--00결과1:"+result);
			 if(result)
			 {
				 replyStr+=" <div class='post-preview'>"
						 + "	   <button type='button' class='pull-right btn btn-xs btn-danger' name='deleteReplyBtn' data-writer='"+list[i].memberId+"' data-rno='"+ list[i].rno +"' style='float: right; margin: 0px 3px;'>삭제</button>"
			            + "    <button type='button' class='pull-right btn btn-xs btn-info' name='modifyReplyBtn' data-writer='"+list[i].memberId+"' data-rno='"+ list[i].rno +"' style='float: right; margin: 0px 3px;'>수정</button>"
		        		+"		<a data-rno='"+list[i].rno +"'>"+list[i].replyContent+"</a>"
		        		+"		<p  data-rno='"+ list[i].rno + "' class='post-meta'>Post by "+list[i].memberId+"  수정 일자:"+replyService.showTime(list[i].replyUpdateDate)+"</p>"
	        			+"</div>";
			}
			 else
			 {
				 replyStr+=" <div class='post-preview'>"
		        		+"		<a data-rno='"+list[i].rno +"'>"+list[i].replyContent+"</a>"
		        		+"		<p  data-rno='"+ list[i].rno + "' class='post-meta'>Post by "+list[i].memberId+"  수정 일자:"+replyService.showTime(list[i].replyUpdateDate)+"</p>"
	        			+"</div>";
			 }
	     	
		       console.log("--00결과2:"+result);
		 }
	
		replyUL.html(replyStr);
		showReplyPage(replyTotal);
		//console.log(replyer);
	
	   })
	   
	  
   }
   $("#insertReply").on("click",function(e){
		  e.preventDefault();
		  console.log("click");
		   var reply={
				   replyContent:$("#replyContent").val(),
				   memberId:replyer,
				  bno: bnoValue };
		   
		   replyService.insertReply(reply,function(result){
			   $("#replyContent").val("");
			   showReplyList(-1);
		   });
	   });
   
   $("#replyList").on("click","button[name='modifyReplyBtn']", function(e){
	    console.log("나:"+replyer);
		 if(!replyer){
			  
				alert("로그인 후 수정이 가능합니다.");
				return;
			} 
			
		var rno = $(this).data("rno");
		var originalReplyer = $(this).data("writer");
			
		 if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			return; 
		 }
			
		$("#replyList button[data-rno='"+ rno +"'][name='deleteReplyBtn']").hide();
	   
	    
	    replyService.readReply(rno, function(reply) {
	       var str = "<textarea data-rno='"+reply.rno+"' name='modifyContent' rows='5' style='width:100%; overflow:auto; white-space:pre-line;'>" + reply.replyContent + "</textarea>";
	       		$("#replyList button[data-rno='"+ rno +"'][name='modifyReplyBtn']").attr("data-mod","modifying");
	       	    $("#replyList a[data-rno='"+ rno +"']").hide();
	       		$("#replyList p[data-rno='"+ rno +"']").before(str);
		});
   });
   
   //수정 또 클릭
   $("#replyList").on("click", "button[name='modifyReplyBtn'][data-mod='modifying']",function(e){
	  	console.log("click"); 
   
         var rno = $(this).data("rno");
         var replyContent = $("#replyList textarea[name='modifyContent']").val();
         var reply = {rno:rno, replyContent:replyContent};
         
            
      replyService.modifyReply(reply, function(result){
            showReplyList(pageNum);
         
      }); 
   });
   
   $("#replyList").on("click","button[name='deleteReplyBtn']", function(e){
	    console.log("나:"+replyer);
	    <sec:authorize access="isAuthenticated()">
			replyer='<sec:authentication property="principal.username"/>';
		</sec:authorize>
	   if(!replyer){
			alert("로그인 후 삭제가 가능합니다.");
			return false;
		}
		 
		var rno = $(this).data("rno");
		var replyer = $(this).data("writer");
		
		
     
     if(confirm("댓글을 삭제하시겠습니까?")) {
		replyService.deleteReply(rno,replyer ,function(result) {
		showReplyList(pageNum);
        
		});
     }
	});
   
   var replyPageFooter = $(".reply-panel-footer");
   function showReplyPage(replyTotal){
	     
	     var endNum = Math.ceil(pageNum / 10.0) * 10; 
	     console.log("endNum:  "+endNum);
	     console.log("replyTotal: "+replyTotal);
	     var startNum = endNum - 9; 
	     
	     var prev = startNum != 1;
	     var next = false;
	     
	     if(endNum * 10 >= replyTotal){
	       endNum = Math.ceil(replyTotal/10.0);
	     }
	     
	     if(endNum * 10 < replyTotal){
	       next = true;
	     }
	     
	     var str = "<ul class='pagination pull-right'>";
	     
	     if(prev){
	            str +="<li class='page-item'>"
	               + "      <a class='page-link' href='"+(startNum-1)+"'>이전</a>"
	               + "</li>";
	         } else {
	            str +="<li class='page-item disabled'>"
	               + " "
	               + "</li>";
	         }
	     
	     for(var i = startNum ; i <= endNum; i++){
	       
	 		var active = (pageNum==i ? "active" : "");
			
			str +="	<li class='page-item "+active+" '>"
				+ "		<a class='page-link' href='"+i+"'>"+i+"</a>"
				+ "	</li>";
	     }
	     
	     if(next){
	            str +="<li class='page-item'>"
	                + "      <a class='page-link' href='"+(endNum+1)+"'>다음 </a>"
	                + "</li>";
	         } else {
	            str +="<li class='page-item disabled'>"
	                + " "
	                + "</li>";
	         }
	    		str +="</ul></div>";
	     
	     
	     replyPageFooter.html(str);
	   }
   
   //페이지 클릭시 해당 댓글 페이지로 이동
   replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       
       var targetPageNum = $(this).attr("href");
       pageNum = targetPageNum;
       
       showReplyList(pageNum);
       
       var offset = $(".post-preview").offset();
      $("html").animate({scrollTop : offset.top},500);
       
     });     
   
   
   
</script>
<%@include file="../includes/footer.jsp" %>