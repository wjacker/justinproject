package com.justin.project.database.dto;

public class Pager {
    private int pageSize;
    private int pageNum;
    private int recFrom;
    private int recCount;
    private String sortField;
    private String sortType;

    public Pager() {
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getRecCount() {
        return recCount;
    }

    public void setRecCount(int recCount) {
        this.recCount = recCount;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getSortType() {
        return sortType;
    }

    public void setSortType(String sortType) {
        this.sortType = sortType;
    }

    public int getRecFrom() {
        return recFrom;
    }

    public void setRecFrom(int recFrom) {
        this.recFrom = recFrom;
    }

    public boolean isValid() {
        return pageSize > 0;
    }
}
