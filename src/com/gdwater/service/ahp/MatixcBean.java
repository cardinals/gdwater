/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gdwater.service.ahp;

import java.util.Vector;

public class MatixcBean {

	private String expression;//表达式
    private String MatixcName;//矩阵名字
    private String[][] matixc_string = null;//字符型矩阵
    private double[][] matixc_double = null;//浮点型矩阵
	Vector<Vector> temMatixc = new Vector();//临时矩阵
    private int Begin_index;//起始点
    private int End_index;//终点
    private int row;//行数
    private int column;//列数

    public MatixcBean() {
    }

    public MatixcBean(String s) {
        this.setExpression(s);
        this.run();
    }

    public String getExpression() {
        return expression;
    }

    public void setExpression(String expression) {
        this.expression = expression;
    }

    public String[][] getMatixc_string() {
        return matixc_string;
    }

    public void setMatixc_string(String[][] matixc_string) {
        this.matixc_string = matixc_string;
    }

    public double[][] getMatixc_double() {
        return matixc_double;
    }

    public void setMatixc_double(double[][] matixc_double) {
        this.matixc_double = matixc_double;
    }

    public String getMatixcName() {
        return MatixcName;
    }

    public void setMatixcName(String MatixcName) {
        this.MatixcName = MatixcName;
    }

    public int getRow() {
        return row;
    }

    public int getColumn() {
        return column;
    }

    public void split_matix() {//切分表达式,把表达式切分成矩阵名和矩阵体两部分
        String[] split_string = new String[2];
        if (this.expression != null) {
        	split_string = this.expression.split("=");
            this.setMatixcName(split_string[0]);
            setVector(split_string[1]);//处理矩阵体
        }        
    }

    public void setVector(String s) {
        int index = 0;
        Vector<String> v = new Vector();//临时存储向量
        String new_string = "";
        while (index < s.length()) {
            if (s.charAt(index) == '[') {
                Begin_index = index + 1;
                index++;
            } else if (s.charAt(index) == ' ' || s.charAt(index) == ',') {
                End_index = index;
                new_string = s.substring(Begin_index, End_index);
                v.addElement(new_string);
                Begin_index = index + 1;
                index++;
            } else if (s.charAt(index) == ';') {
                End_index = index;
                new_string = s.substring(Begin_index, End_index);
                v.addElement(new_string);
                this.temMatixc.addElement(v);
                v = new Vector();
                Begin_index = index + 1;
                index++;
            } else if (s.charAt(index) == ']') {
                End_index = index;
                new_string = s.substring(Begin_index, End_index);
                v.addElement(new_string);
                this.temMatixc.addElement(v);
                index++;
            } else {
                index++;
            }
        }
    }

    public void setRowColumn() {    	
        row = this.temMatixc.size();
        if (row != 0) {
        	column = ((Vector) this.temMatixc.get(0)).size();
            for (int i = 1; i < getRow(); i++) {
                int column2 = ((Vector) this.temMatixc.get(i)).size();
                if (column2 > getColumn()) {
                    column = column2;
                }
            }
        }        
    }

    public void BuildMatrix() {
        matixc_double = new double[getRow()][getColumn()];
        int v_row = getRow();
        int v_column = 0;
        try {
            for (int i = 0; i < v_row; i++) {
                v_column = ((Vector) this.temMatixc.get(i)).size();
                for (int j = 0; j < v_column; j++) {
                    Double d = Double.parseDouble(((Vector) this.temMatixc.get(i)).get(j).toString());
                    matixc_double[i][j] = d;
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void paint_matrix() {//打印出刚输入的矩阵
        System.out.println(this.MatixcName + "=");
        for (int i = 0; i < getRow(); i++) {
            for (int j = 0; j < getColumn(); j++) {
                if (j == getColumn() - 1) {
                    System.out.print(matixc_double[i][j]);
                    System.out.println("");
                } else {
                    System.out.print(matixc_double[i][j] + " ");
                }
            }
        }
    }
    
    public void run(){
        split_matix();
        setRowColumn();
        BuildMatrix();
        paint_matrix();
    }
}
