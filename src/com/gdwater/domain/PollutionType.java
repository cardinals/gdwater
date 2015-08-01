package com.gdwater.domain;
// default package



/**
 * PollutionType entity. @author MyEclipse Persistence Tools
 */

public class PollutionType  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
     private String pollutionType;


    // Constructors

    /** default constructor */
    public PollutionType() {
    }

    
    /** full constructor */
    public PollutionType(String pollutionType) {
        this.pollutionType = pollutionType;
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
   








}