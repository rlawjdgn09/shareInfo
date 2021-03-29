
<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
          <div class="col-lg-12 col-md-12 mx-auto">
            <div class="bs-component">
              <form id="frm" method="post" action="/member/modifyMember">
                <fieldset>
                  <legend>마이 페이지</legend>
                  <div class="col-lg-8 col-md-10 mx-auto">
                   <div class="form-group">
                    <label for="exampleInputPassword1">Id</label>
                    <input type="text" class="form-control" id="memberId" name="memberId" value="${member.memberId}" readonly="readonly">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="memberPassword" name="memberPassword" value="${member.memberPassword}">
                  </div>
                   <div class="form-group">
                    <label for="exampleInputPassword1">Name</label>
                    <input type="text" class="form-control" id="memberName" name="memberName" value="${member.memberName}">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" id="memberEmail"  name="memberEmail" aria-describedby="emailHelp" value="${member.memberEmail}">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Address</label>
                    <input type="text" class="form-control" id="memberAddress" name="memberAddress" value="${member.memberAddress}">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">PhoneNumber</label>
                    <input type="text" class="form-control" id="memberPhoneNumber" name="memberPhoneNumber" value="${member.memberPhoneNumber}">
                  </div>
                   <div class="form-group">
                    <label for="exampleInputPassword1">가입 일자</label>
                    <input type="text" class="form-control" id="joinDate" name="joinDate" value="${member.joinDate}" readonly="readonly">
                  </div>
                  
                 
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  <button type="submit" class="btn btn-primary">수정하기</button> <button type="button" class="btn btn-primary" onClick="history.go(-1)">취소</button> <button id="removeMember"type="button" class="btn btn-primary">탈퇴하기</button> 
             	</div>
             	</fieldset>
              </form>
          
          </div>
    	</div>      
   </div>
   
  	<script>
  		var frm=$("#frm");
  		$("#removeMember").on("click",function(e){
  			e.preventDefault();
  			frm.attr("action","/member/removeMember").submit();
  		})
  		
  	</script>
<%@include file="../includes/footer.jsp" %>