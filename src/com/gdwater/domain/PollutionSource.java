package com.gdwater.domain;
// default package



/**
 * PollutionSource entity. @author MyEclipse Persistence Tools
 */

public class PollutionSource  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
     private String pollutionType;
     private Double geox;
     private Double geoy;


    // Constructors

    /** default constructor */
    public PollutionSource() {
    }

    
    /** full constructor */
    public PollutionSource(String pollutionType, Double geox, Double geoy) {
        this.pollutionType = pollutionType;
        this.geox = geox;
        this.geoy = geoy;
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

    public Double getGeox() {
        return this.geox;
    }
    
    public void setGeox(Double geox) {
        this.geox = geox;
    }

    public Double getGeoy() {
        return this.geoy;
    }
    
    public void setGeoy(Double geoy) {
        this.geoy = geoy;
    }
   








}