/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gdwater.service.ahp;

import net.sf.json.JSONObject;

public class level {

	private double[][] matrix = null;//待求矩阵
    private static int dim = 0;//维数
    private double[][] am;
	private double[] W;
    private double[] bm;
    private double lamuda = 0.0d;// 入
    private double CI = 0.0d;
    private double RI = 0.0d;
    private double CR = 0.0d;
    //private double w = 0.0d;
    private double CR_ACCEPTABLE = 0.01d;

    public level() {
    }

    public level(double[][] matrix) {
        this.matrix = matrix;
        level.dim = this.matrix.length;
        init();
        this.run();
        this.run2();
        this.run3();
    	//this.paint();
    }
    
    static {
    	
    }

    private void init() {
        setRI();
        am = new double[dim][dim];
        W = new double[dim];
        bm = new double[dim];
    }

    private void run() {//第一步 列向量归一化

        double a1 = 0.0d;
        for (int i = 0; i < dim; i++) {
            a1 = 0.0d;
            for (int j = 0; j < dim; j++) { //每一列向量的和

                a1 = matrix[j][i] + a1;
            }
            for (int j = 0; j < dim; j++) { //除以列和,完成第一步列向量归一化

                am[j][i] = matrix[j][i] / a1;
            }
        }
        for (int i = 0; i < dim; i++) {  //按行求和

            for (int j = 0; j < dim; j++) {
                W[i] = W[i] + am[i][j];
            }
        }
    }

    private void run2() {  //第二步  对W 再做一次归一化

        double a1 = 0.0d;
        for (int i = 0; i < dim; i++) { //列向求和

            a1 = W[i] + a1;
        }
        for (int i = 0; i < dim; i++) {//完成归一化

            W[i] = W[i] / a1;
        }
    }

    private void run3() {
        for (int i = 0; i < dim; i++) { //求 A * w

            for (int j = 0; j < dim; j++) {
                bm[i] = bm[i] + W[j] * matrix[i][j];
            }
        }
        for (int i = 0; i < dim; i++) {   //求 入

            lamuda = lamuda + bm[i] / W[i];
        }
        lamuda = lamuda / dim;
        CI = (lamuda - dim) / (dim - 1); //求 CI，一致性指数

        CR = CI / RI;//求 CR，一致性比率

    }

//    private void paint() {
//        System.out.println("Am=");
//        for (int i = 0; i < dim; i++) {
//            System.out.print("[ ");
//            for (int j = 0; j < dim; j++) {
//                System.out.print(am[i][j] + " ");
//            }
//            System.out.println("]");
//        }
//
//        System.out.println("W=");
//        System.out.print("[ ");
//        for (int i = 0; i < dim; i++) {
//        	System.out.print(W[i] + " ");
//        }
//        System.out.println("]");
//        
//        System.out.println("特征向量 λ=" + lamuda);
//        System.out.println("一致性指数 CI=" + CI);
//        String result = isConsistant() ? ", 小于<10%，符合一致性要求" : ", 大于>10%，不符合一致性要求，请修改权重矩阵";
//        System.out.println("一致性比率 CR=" + CR + result);
//    }
    
    private void setRI() {
        switch(dim){
            case 1:this.RI=0;break;
            case 2:this.RI=0;break;
            case 3:this.RI=0.58d;break;
            case 4:this.RI=0.90d;break;
            case 5:this.RI=1.12d;break;
            case 6:this.RI=1.24d;break;
            case 7:this.RI=1.32d;break;
            case 8:this.RI=1.41d;break;
            case 9:this.RI=1.45d;break;
            case 10:this.RI=1.49d;break;
            case 11:this.RI=1.51d;break;
            default:this.RI=0;
        }
    }
    
    //判断矩阵是否一致
    public boolean isConsistant() {
    	if (this.CR < this.CR_ACCEPTABLE)
    		return true;
		return false;    	
    }

    //返回权重向量
	public double[] getWeightVector() {
		return this.W;
	}

	//返回最大特征向量
	public double getLamuda() {
		return this.lamuda;
	}

	//返回一致性指数
	public double getConsistantIndex() {
		return this.CI;
	}

	//返回一致性比率
	public double getConsistantRatio() {
		return this.CR;
	}
    
	
	public JSONObject getResultJson() {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("weightvector", getWeightVector());
		jsonObject.put("lamuda", getLamuda());
		jsonObject.put("consistantindex", getConsistantIndex());
		jsonObject.put("consistantratio", getConsistantRatio());
		
		return jsonObject;
	}
	
}
