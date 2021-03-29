package org.spring5.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	private String category;
	
	public Criteria() {
		this(1,10);
	}
	public Criteria(int pageNum, int amount) {
		this.pageNum= pageNum;
		this.amount=amount;
		
	}
	
	
	public Criteria(int pageNum, int amount,String category) {
		this.pageNum= pageNum;
		this.amount=amount;
		this.category = category;
	}
	
	public String[] getTypeArr() {
		return type==null? new String[] {}:type.split("");
	}
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
														   .queryParam("pageNum", this.pageNum)
														   .queryParam("amount",this.getAmount())
														   .queryParam("category", this.getCategory())
														   .queryParam("type", this.getType())
														   .queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
	
}
