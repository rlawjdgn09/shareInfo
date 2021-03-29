console.log("서비스 시작");
var replyService = (function(){
	
	//댓글 목록
	function getReplyList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		console.log(page);
	
		
		var url =  "/replies/getReplyList/" + bno + "/" + page + ".json";
		
		
		$.ajax({
			type : 'get',
			url : url,
			success : function(result, status, xhr) {
				if(callback) {
					//callback(result);
					callback(result.replyTotal, result.list);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}
	
	function insertReply(reply,callback){
		console.log(reply);
		$.ajax({
			type : 'post',
			url: "/replies/insertReply",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					console.log("success");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}
	function readReply(rno, callback, error) {
			
			
			$.ajax({
				type : 'get',
				url : '/replies/' + rno + ".json",
				success : function(result, status, xhr) {
					if(callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			})
		}
	
		function modifyReply(reply, callback, error) {
				$.ajax({
					type : 'put',
					url : '/replies/' + reply.rno,
					data : JSON.stringify(reply),
					contentType: "application/json; charset=utf-8",
					success : function(result, status, xhr) {
						if(callback) {
							callback(result);
						}
					},
					error : function(xhr, status, er) {
						if(error) {
							error(er);
						}
					}
				})
			}
		//댓글 삭제
		function deleteReply(rno,replyer,callback, error) {
			
		$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				data : JSON.stringify({rno:rno, memberId :replyer}),
				contentType : "application/json; charset=utf-8",
				success : function(deleteResult, status, xhr) {
					if(callback) {
						callback(deleteResult);
					}
				},
				error : function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			})
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
		getReplyList:getReplyList,
		insertReply:insertReply,
		readReply:readReply,
		modifyReply:modifyReply,
		deleteReply:deleteReply,
		showTime: showTime
		
	}
	
})();




