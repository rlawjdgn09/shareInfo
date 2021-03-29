
<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                      <form id="frmBoard" method="post" action="/board/modifyBoard">
                      		<br>
		                      	  <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">카테고리</label>
		                              <div class="col-sm-8">
		                                  <select name="category" class="form-control">
		                                      <option value="">Select One Value Only</option>
		                                      <option value="A" ${board.category == 'A' ? 'selected' : '' }>Info</option>
		                                      <option value="B" ${board.category == 'B' ? 'selected' : '' }>Tip</option>
		                                  </select>
		                              </div>
		                          </div>
		                      	 <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">title</label>
		                              <div class="col-sm-8">
		                                  <input name="title" type="text" class="form-control" value="${board.title}">
		                              </div>
		                          </div>
		                          <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">Textarea</label>
		                              <div class="col-sm-8">
		                                  <textarea name="contents" rows="5" cols="30" class="form-control" placeholder="Default textarea">${board.contents }</textarea>
		                              </div>
		                          </div>
		                          <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">Upload File</label>
		                              <div class="col-sm-8">
		                                  <input name="imageFileName" type="file" class="form-control">
		                              </div>
		                          </div>
		                           <div class="form-group row">
		                              <label class="col-sm-2 col-form-label">작성자</label>
		                              <div class="col-sm-8">
		                                  <input name="memberId" type="text" class="form-control" value="${board.memberId}" readonly="readonly">
		                              </div>
		                          </div>
		                      	<input type="hidden" name="bno" value='${board.bno}' />
		                      	<input type="hidden" name="pageNum" value='${cri.pageNum}' />
		                      	<input type="hidden" name="amount" value='${cri.amount}' />
		                      	
                 				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		                        <input type="submit" id="modifyBoard" class="btn btn-info waves-effect waves-light" value="수정하기"/><input type="reset"  class="btn btn-info waves-effect waves-light" value="초기화"/>
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
	
	$("#modifyBoard").on("click",function(e){
		e.preventDefault();
		frmBoard.submit();
	})
	
</script>
<%@include file="../includes/footer.jsp" %>