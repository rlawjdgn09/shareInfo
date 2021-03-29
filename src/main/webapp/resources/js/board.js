console.log("서비스 시작");
var boardService = (function(){
	
	function getBoardList(board,callback, error){
	
		var pageNum = board.pageNum;
		var amount = board.amount;
		var type=board.type;
		var keyword=board.keyword;
		var category=board.category;
		
		$.ajax({
			type : "get",
			url : "/board/restGetBoardList",
			data: {pageNum:pageNum, amount:amount,type:type,keyword:keyword,category:category},
			contentType : "text/plain; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr,status,er){
				if(error){
					
					error(er);
				}
			}
		}); //ajax-end
	} // getList-end
	
	function getTotalPageCnt(board,callback){
		var pageNum = board.pageNum;
		var amount = board.amount;
		var type= board.type;
		var keyword = board.keyword;
		var category=board.category;
		
		$.ajax({
			type : "get",
			url :  "/board/restBoardGetTotalPageCnt",
			data : {pageNum:pageNum, amount:amount, type : type, keyword : keyword,category:category},
			contentType : "text/plain; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	function showTime(timeValue){
		var today=new Date();
		
		var currentYY=today.getFullYear();
		var currentMM = today.getMonth()+1;
		var currentDD = today.getDate();
		
		var dateObj = new Date(timeValue);
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		var yyyy = dateObj.getFullYear();
		var mm = dateObj.getMonth()+1;
		var dd = dateObj.getDate();
		
		if(yyyy==currentYY&&mm==currentMM&&dd==currentDD)
		{
			return [ (hh>9 ? '':'0')+hh, ':', (mi>9 ? '':'0')+mi, ':', (ss>9 ? '':'0')+ss].join('');
		}
		else{
			return [ yyyy, ".", (mm>9 ? '':'0')+mm, '.', (dd>9 ? '':'0')+dd].join('');
		}
	
		
	}// showTime-end
	
	return {
		getBoardList : getBoardList,
		showTime: showTime,
		getTotalPageCnt:getTotalPageCnt
	}
	
})();




