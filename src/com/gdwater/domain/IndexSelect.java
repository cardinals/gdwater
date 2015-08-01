package com.gdwater.domain;
// default package



/**
 * IndexSelect entity. @author MyEclipse Persistence Tools
 */

public class IndexSelect  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
     private String indexId;
     private String pollutionType;
     private String indexName;
     private Double threshold;


    // Constructors

    /** default constructor */
    public IndexSelect() {
    }

	/** minimal constructor */
    public IndexSelect(String indexId, String pollutionType, String indexName) {
        this.indexId = indexId;
        this.pollutionType = pollutionType;
        this.indexName = indexName;
    }
    
    /** full constructor */
    public IndexSelect(String indexId, String pollutionType, String indexName, Double threshold) {
        this.indexId = indexId;
        this.pollutionType = pollutionType;
        this.indexName = indexName;
        this.threshold = threshold;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getIndexId() {
        return this.indexId;
    }
    
    public void setIndexId(String indexId) {
        this.indexId = indexId;
    }

    public String getPollutionType() {
        return this.pollutionType;
    }
    
    public void setPollutionType(String pollutionType) {
        this.pollutionType = pollutionType;
    }

    public String getIndexName() {
        return this.indexName;
    }
    
    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }

    public Double getThreshold() {
        return this.threshold;
    }
    
    public void setThreshold(Double threshold) {
        this.threshold = threshold;
    }
   








}