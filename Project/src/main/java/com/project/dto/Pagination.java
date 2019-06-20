package com.project.dto;

public class Pagination {
	private int totalRecords;
	private int page;
	private int rows;
	private int rowStart;
	private int rowEnd;
	private int totalPages;
	private int blocks;
	private int blockStart;
	private int blockEnd;
	
	public Pagination(int totalRecords, int page) {
		//기본적으로 전체 레코드 수 받아오고 rows, blocks 선택 안하면 20, 5 로 임의 지정
		this(totalRecords, page, 20, 5);
	}
		
	
	public Pagination(int totalRecords, int page, int rows, int blocks) {
		this.totalRecords = totalRecords;
		this.page = page;
		this.rows = rows;
		this.rowStart = (page * rows) - (rows - 1);
		this.rowEnd = (page * rows);
		this.totalPages = (int)(Math.ceil(totalRecords / (double)rows));
		
		this.blocks = blocks;
		this.blockStart = (((page - 1) / blocks) * blocks) + 1;
		this.blockEnd = (((page - 1) / blocks) * blocks) + blocks;
		
		if(blockEnd > totalPages) {										//block 마지막이 전체페이지 보다 크면 동기화
			blockEnd = totalPages;
		}
		
	}


	public int getTotalRecords() {
		return totalRecords;
	}


	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}


	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
	}


	public int getRows() {
		return rows;
	}


	public void setRows(int rows) {
		this.rows = rows;
	}


	public int getRowStart() {
		return rowStart;
	}


	public void setRowStart(int rowStart) {
		this.rowStart = rowStart;
	}


	public int getRowEnd() {
		return rowEnd;
	}


	public void setRowEnd(int rowEnd) {
		this.rowEnd = rowEnd;
	}


	public int getTotalPages() {
		return totalPages;
	}


	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}


	public int getBlocks() {
		return blocks;
	}


	public void setBlocks(int blocks) {
		this.blocks = blocks;
	}


	public int getBlockStart() {
		return blockStart;
	}


	public void setBlockStart(int blockStart) {
		this.blockStart = blockStart;
	}


	public int getBlockEnd() {
		return blockEnd;
	}


	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	
	
}
