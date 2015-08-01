package com.gdwater.domain;
// default package



/**
 * AHPLayerTwo entity. @author MyEclipse Persistence Tools
 */

public class AHPLayerTwo  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
     private String pollutionType;
     private String rowName;
     private String rowId;
     private String colName;
     private String colId;
     private Double score;


    // Constructors

    /** default constructor */
    public AHPLayerTwo() {
    }

	/** minimal constructor */
    public AHPLayerTwo(String pollutionType, String rowName, String rowId, String colName, String colId) {
        this.pollutionType = pollutionType;
        this.rowName = rowName;
        this.rowId = rowId;
        this.colName = colName;
        this.colId = colId;
    }
    
    /** full constructor */
    public AHPLayerTwo(String pollutionType, String rowName, String rowId, String colName, String colId, Double score) {
        this.pollutionType = pollutionType;
        this.rowName = rowName;
        this.rowId = rowId;
        this.colName = colName;
        this.colId = colId;
        this.score = score;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getPollutionType() {
        return this.pollutionType;
    }
    
    public void setPollutionType(String pollutionType) {
        this.pollutionType = pollutionType;
    }

    public String getRowName() {
        return this.rowName;
    }
    
    public void setRowName(String rowName) {
        this.rowName = rowName;
    }

    public String getRowId() {
        return this.rowId;
    }
    
    public void setRowId(String rowId) {
        this.rowId = rowId;
    }

    public String getColName() {
        return this.colName;
    }
    
    public void setColName(String colName) {
        this.colName = colName;
    }

    public String getColId() {
        return this.colId;
    }
    
    public void setColId(String colId) {
        this.colId = colId;
    }

    public Double getScore() {
        return this.score;
    }
    
    public void setScore(Double score) {
        this.score = score;
    }
   








}