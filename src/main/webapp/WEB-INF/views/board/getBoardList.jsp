<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="container">
    <div class="row">
      <div class="col-lg-12 col-md-12 mx-auto">
    <div class="card">
                <div class="card-header">
                    <h5>Hover Table</h5>
                    <span>use class <code>table-hover</code> inside table element</span>
                    <sec:authorize access="isAuthenticated()">
                    	<button id="writeBoard" class="btn btn-info waves-effect waves-light">글쓰기</button>
                    </sec:authorize>
                </div>
                  <!-- 리스트 -->
			<div class="col-md-12 col-sm-12">
				<!-- 검색 조건 -->
				<div class="row">
					<div class="col-sm-5">
						<!-- amount change -->
						<div class="pull-right">
			           		<form id='searchForm' action="/board/getBoardList" method="get">
			           			<select class="form-control" name="category">
									<option value="" ${pageMaker.cri.category == null or empty pageMaker.cri.category ? "selected" : "" }>분류</option>
									<option value="A" ${pageMaker.cri.category eq 'A' and not empty pageMaker.cri.category ? "selected" : "" }>Info</option>
									<option value="B" ${pageMaker.cri.category eq 'B' and not empty pageMaker.cri.category ? "selected" : "" }>Tips</option>
								</select>
								<select class="form-control" name="type">
									<option value="TCW" >모든 조건</option>
									<option value="T" ${pageMaker.cri.type eq 'T' and not empty pageMaker.cri.keyword ? "selected" : ""}>제목</option>
									<option value="C" ${pageMaker.cri.type eq 'C' and not empty pageMaker.cri.keyword ? "selected" : ""}>내용</option>
									<option value="W" ${pageMaker.cri.type eq 'W' and not empty pageMaker.cri.keyword ? "selected" : ""}>작성자</option>
									<option value="TC" ${pageMaker.cri.type eq 'TC' and not empty pageMaker.cri.keyword ? "selected" : ""}>제목 or 내용</option>
									<option value="TW" ${pageMaker.cri.type eq 'TW' and not empty pageMaker.cri.keyword ? "selected" : ""}>제목 or 작성자</option>
									<option value="CW" ${pageMaker.cri.type eq 'CW' and not empty pageMaker.cri.keyword ? "selected" : ""}>내용 or 작성자</option>
								</select>
								<div class="form-group input-group">
									<input class="form-control" type='text' name="keyword" value="${pageMaker.cri.keyword}">
									<span class="input-group-btn">	
										<button type="submit" class="btn btn-default">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div>	
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" >
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}" >
			           		</form>
			           	</div><!-- /.pull-right input-sm -->
					</div>
					<!-- /.col-sm-6 -->
				</div>
				<!-- /.row -->
                <div class="card-block table-border-style">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead id="boardListTitle">
                                <tr>
                                    <th>번호</th>
                                    <th>분류</th>
                                    <th>제목</th>
                                    <th>등록일자</th>
                                    <th>등록자</th>
                                    <th>조회수</th>
                                </tr>
                              
                            </thead>
                            <tbody id="tableBodyList">
                            
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div>
                <ul class="pagination" id="tableListFoot">
                    <li class="page-item">
	                    <a class="page-link" href="#">»</a>
	                  </li>
                </ul>
              </div>
            </div>
      </div>
    </div>
  </div>
</div>
	  <form id="actionForm" action="/board/getBoardList" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
				<input type="hidden" name="type" value="${pageMaker.cri.type}" />
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
				<input type="hidden" name="category" value="${pageMaker.cri.category}" />
		</form>
  <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
             	 <h4 class="modal-title" id="myModalLabel">처리 결과</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
            	
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          	</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
  
  
<script src="/resources/js/board.js"></script>			
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";


$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
});


//중복 방지, Modal
window.addEventListener('popstate',function(event){
	history.pushState(null,null,location.href);
});

$(document).ready(function(){
	var result = "${result}";
	checkModal(result);
	history.pushState(null,null,location.href); 
});

function checkModal(result){
	if(result ==='' || history.state){
		return;
	}
	if(parseInt(result)>0){
		$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
	} else if(result=='modify'){
		$(".modal-body").html("게시글이 수정되었습니다.");
	} else if(result=='remove'){
		$(".modal-body").html("게시글이 삭제되었습니다.");
	}
	
	$("#myModal").modal("show");
};


var tableBodyList=$("#tableBodyList");
var tableListFoot=$("#tableListFoot");
var actionForm = $("#actionForm");

var pageNum=${pageMaker.cri.pageNum};
var amount=${pageMaker.cri.amount};


var type = actionForm.find("input[name='type']").val()||"";
var keyword = actionForm.find("input[name='keyword']").val() || "";
var category = actionForm.find("input[name='category']").val() || "";


var total=${pageMaker.total};

showList(pageNum,amount,type,keyword,category);

function showList(pageNum,amount,type,keyword,category){
	boardService.getBoardList({
		pageNum:pageNum,
		amount:amount,
		type:type,
		keyword:keyword,
		category:category
		},
		function(list){
		//console.log(list);
		var str="";
		if(list==null || list.length==0){
			str +="<tr>"
				+ "		<td colspan='6' style='text-align:center'><h3>게시글이 없습니다.</h3></td>"
				+ "</tr>";
				tableBodyList.html(str);
			return;
		} 
		
		for(var i=0, len=list.length || 0; i<len;i++){
				//console.log(list[i].category);
				if(list[i].category=='A')
				{
					list[i].category='Info';
				}
              	else if(list[i].category=='B')
 				{
              		list[i].category='Tips';
 				}
              str+="<tr>"
              	 +"	  <td>"+list[i].bno+"</td>"
              	 +"	  <td>"+list[i].category+"</td>"
              	 +"	  <td>"+list[i].title+"</td>"
              	 +"	  <td>"+boardService.showTime(list[i].writeDate)+"</td>"
              	 +"	  <td>"+list[i].memberId+"</td>"
              	 +"	  <td>"+list[i].countView+"</td>"
           
            }//for-end
			//console.log(str);
            tableBodyList.html(str);
            showBoardPage(total);
	});
	
	
     
	function showBoardPage(total){
		var endPage=Math.ceil(pageNum/10.0)*10;
		var startPage = endPage-9;
		
		var prev=(startPage!=1);
		var next= false;
		
		if(endPage*amount >= total){
			endPage=Math.ceil(total/(amount*1.0));
		}
		next = (endPage * amount < total);
		
		var str="";
		
		if(prev==true){
			str+=" <li calss='page-item'>"
				+"		<a class='page-link' href='"+(startPage-1)+"'>이전</a>"
				+" </li>";
		}else
		{
			str+=" <li calss='page-item disabled'>"
				+" </li>";
		}
		
		for(var i=startPage;i<=endPage;i++){
			var active = (pageNum==i?"active":"");
			str +="	<li class='page-item "+active+" '>"
				+ "		<a class='page-link' href='"+i+"'>"+i+"</a>"
				+ "	</li>";
		}
		if(next==true){
			str +="	<li class='page-item'>"
				+ "		<a class='page-link' href='"+(endPage+1)+"'>다음 </a>"
				+ "	</li>";
		} else {
			str +="	<li class='page-item disabled'>"
				+ "	</li>";
		}
		tableListFoot.html(str);
		
	}
	
	tableListFoot.on("click","li a", function(e){
		e.preventDefault();
		pageNum = $(this).attr("href");
		showList(pageNum,amount,type,keyword,category)
		console.log(pageNum);
		
		var offset = $("#boardListTitle").offset();
		$("html").animate({scrollTop : offset.top},500);
		
	});
	
	
	var actionForm=$("#actionForm");
	
	tableBodyList.on("click","tr", function(e){
		  	e.preventDefault();

		    var bno=$(this).children().eq(0).text();
		    actionForm.append("<input type='hidden' name='bno' value='"+bno+"'>");
		    actionForm.find("input[name='pageNum']").val(pageNum);
    		actionForm.find("input[name='amount']").val(amount);
    		actionForm.find("input[name='type']").val(type);
    		actionForm.find("input[name='keyword']").val(keyword);
    		actionForm.find("input[name='category']").val(category);
    		
		    actionForm.attr("action","/board/readBoard");
		    
			
    		actionForm.submit();
		   
		});
	
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",function(e){
		e.preventDefault();
		
		pageNum=1;
		amount=10;
		type = searchForm.find("select[name='type']").val();
		keyword = searchForm.find("input[name='keyword']").val();
		category= searchForm.find("select[name='category']").val();
		
		var board={pageNum : pageNum, amount:amount, type:type, keyword:keyword,category:category};
		boardService.getTotalPageCnt(board,
			function(result){
			total=result;
		});
		
		showList(pageNum,amount,type,keyword,category);
	});
	
	$("#writeBoard").on("click",function(){
		self.location="/board/insertBoard";
	})
	}
</script>
<%@include file="../includes/footer.jsp" %>
