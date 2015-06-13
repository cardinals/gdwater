package com.gdwater.domain;



/**
 * Index entity. @author MyEclipse Persistence Tools
 */

public class Index  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
     private String indexId;
     private String indexType;
     private String indexName;


    // Constructors

    /** default constructor */
    public Index() {
    }

    
    /** full constructor */
    public Index(String indexId, String indexType, String indexName) {
        this.indexId = indexId;
        this.indexType = indexType;
        this.indexName = indexName;
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

    public String getIndexType() {
        return this.indexType;
    }
    
    public void setIndexType(String indexType) {
        this.indexType = indexType;
    }

    public String getIndexName() {
        return this.indexName;
    }
    
    public void setIndexName(String indexName) {
        this.indexName = indexName;
    }
   








}