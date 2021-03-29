
<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
          <div class="col-lg-12 col-md-12 mx-auto">
            <div class="bs-component">
              <form id="frm" method="post" action="/member/insertMember">
                <fieldset>
                  <legend>회원 가입</legend>
                  <div class="col-lg-8 col-md-10 mx-auto">
                   <div class="form-group">
                    <label for="exampleInputPassword1">Id</label>
                    <input type="text" class="form-control" id="memberId" name="memberId" placeholder="Id">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="memberPassword" name="memberPassword" placeholder="Password">
                  </div>
                   <div class="form-group">
                    <label for="exampleInputPassword1">Name</label>
                    <input type="text" class="form-control" id="memberName" name="memberName" placeholder="Name">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" id="memberEmail"  name="memberEmail" aria-describedby="emailHelp" placeholder="Enter email">
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Address</label>
                    <input type="text" class="form-control" id="memberAddress" name="memberAddress" placeholder="Address">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">PhoneNumber</label>
                    <input type="text" class="form-control" id="memberPhoneNumber" name="memberPhoneNumber" placeholder="PhoneNumber">
                  </div>
                  
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  <button type="submit" class="btn btn-primary">회원가입</button> <button type="reset" class="btn btn-primary">초기화</button>
             	</div>
             	</fieldset>
              </form>
          
          </div>
    	</div>      
   </div>
<%@include file="../includes/footer.jsp" %>