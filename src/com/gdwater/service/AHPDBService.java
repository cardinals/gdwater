package com.gdwater.service;

import java.util.List;
import java.util.UUID;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.gdwater.domain.AHPLayerOne;
import com.gdwater.domain.AHPLayerTwo;
import com.gdwater.domain.IndexSelect;
import com.gdwater.service.ahp.MatixcBean;
import com.gdwater.service.ahp.Matrix;
import com.gdwater.service.ahp.level;
import com.gdwater.util.HibernateUtil;

import net.sf.json.JSONObject;

public class AHPDBService {

	private HttpServletRequest request;
	private JSONObject jsonObj;
	private String serviceType = null;

	public AHPDBService() {

	}

	public JSONObject getJsonObj() {
		return this.jsonObj;
	}

	public void setJsonObj(JSONObject obj) {
		this.jsonObj = obj;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void serviceProcess() {
		this.serviceType = this.request.getParameter("servicetype");

		switch (this.serviceType) {
			// 获取每个污染类型的自定义指标
		case "get-index-of-pollutiontype":
			this.getIndexOfPollutionType();
			// 保存第一、二层的专家打分
		case "sava-ahp-scores":
			this.saveAHPScores();
			// 获取上次专家打分
		case "get-ahp-scores":
			this.getAHPScores();
			// 计算结果
		case "calculate-result":
			this.calculateResult();
		default:
			break;
		}
	}

	private void getIndexOfPollutionType() {
		String pollutiontype = this.request.getParameter("pollutiontype");

		String hql = "from IndexSelect indexselect where indexselect.pollutionType = ?";
		String parameters[] = { pollutiontype };

		List<IndexSelect> list = HibernateUtil.executeQuery(hql, parameters);
		int len = list.size();
		int count = 0;
		String[] index = new String[len];
		for (IndexSelect indexselect : list) {
			index[count] = indexselect.getIndexName();
			count++;
		}

		jsonObj.put("success_get_index_of_pollutiontype", true);
		jsonObj.put("index_set", index);
	}

	private void saveAHPScores() {
		String[] pollutiontype = this.request
				.getParameterValues("pollutiontype[]");
		String[] indexname = this.request.getParameterValues("indexname[]");
		String[] layeronematrix = this.request
				.getParameterValues("layeronematrix[]");
		String[] layertwomatrix = this.request
				.getParameterValues("layertwomatrix[]");

		if (pollutiontype != null) {
			int pollutiontypelen = pollutiontype.length;

			String[][] layerone = new String[pollutiontypelen][pollutiontypelen];

			if (layeronematrix != null) {
				for (int i = 0; i < pollutiontypelen; i++) {
					String tmp = layeronematrix[i];
					for (int j = 0; j < pollutiontypelen; j++) {
						layerone[i][j] = tmp.split(",")[j];
					}
				}
			}

			String hql1 = "delete AHPLayerOne";
			HibernateUtil.excuteUpdate(hql1, null);

			for (int i = 0; i < pollutiontypelen; i++) {
				for (int j = 0; j < pollutiontypelen; j++) {
					AHPLayerOne ahplayerone = new AHPLayerOne();
					ahplayerone.setRowId(UUID.randomUUID().toString());
					ahplayerone.setRowName(pollutiontype[i]);
					ahplayerone.setColId(UUID.randomUUID().toString());
					ahplayerone.setColName(pollutiontype[j]);
					ahplayerone.setScore(Double.valueOf(layerone[i][j]));

					HibernateUtil.save(ahplayerone);
				}
			}

			if (indexname != null) {				
				String [][][] layertwo = new String[pollutiontypelen][16][16];

				for (int i = 0; i<pollutiontypelen; i++) {									
					if (layertwomatrix != null) {
						String [] tmp1 = layertwomatrix[i].split(";");
						for (int j = 0; j < indexname[i].split(",").length; j++) {
							String [] tmp2 = tmp1[j].split(",");
							for (int k = 0; k < indexname[i].split(",").length; k++) {
								layertwo[i][j][k] = tmp2[k];
							}
						}
					}
				}
				
				String hql2 = "delete AHPLayerTwo";
				HibernateUtil.excuteUpdate(hql2, null);

				for (int i = 0; i < pollutiontypelen; i++) {
					String[] index = indexname[i].split(",");
					for (int j = 0; j < indexname[i].split(",").length; j++) {
						for (int k = 0; k < indexname[i].split(",").length; k++) {
							AHPLayerTwo ahplayertwo = new AHPLayerTwo();
							ahplayertwo.setPollutionType(pollutiontype[i]);
							ahplayertwo.setRowId(UUID.randomUUID().toString());
							ahplayertwo.setRowName(index[j]);
							ahplayertwo.setColId(UUID.randomUUID().toString());
							ahplayertwo.setColName(index[k]);
							ahplayertwo.setScore(Double.valueOf(layertwo[i][j][k]));
							
							HibernateUtil.save(ahplayertwo);
						}
					}
				}
			}
		}
		
		this.jsonObj.put("success_save_ahp_scores", true);
	}
	
	private void getAHPScores() {
		String hql1 = "from AHPLayerOne";
		String hql2 = "from AHPLayerTwo";		
		List<AHPLayerOne> list1 = HibernateUtil.executeQuery(hql1, null);
		List<AHPLayerTwo> list2 = HibernateUtil.executeQuery(hql2, null);		
		int len1 = list1.size();
		int len2 = list2.size();
		String [][] ahplayerone = new String[len1][3];
		String [][] ahplayertwo = new String[len2][4];
		
		int count = 0;
		for (AHPLayerOne layerone:list1) {
			ahplayerone[count][0] = layerone.getRowName();
			ahplayerone[count][1] = layerone.getColName();
			ahplayerone[count][2] = layerone.getScore().toString();
			count ++;
		}
		count = 0;
		for (AHPLayerTwo layertwo:list2) {
			ahplayertwo[count][0] = layertwo.getPollutionType();
			ahplayertwo[count][1] = layertwo.getRowName();
			ahplayertwo[count][2] = layertwo.getColName();
			ahplayertwo[count][3] = layertwo.getScore().toString();
			count ++;
		}
		
		this.jsonObj.put("success_get_ahp_scores", true);
		this.jsonObj.put("ahplayerone", ahplayerone);
		this.jsonObj.put("ahplayertwo", ahplayertwo);
	}
	
	private void calculateResult() {
		//第一层归一化矩阵
		double[][] s;
		//第一层归一化矩阵特征值
		double lamuda = 0.0;
		//第一层权重矩阵
		double[] weightvector1;
		//第一层矩阵一致性指数
		double consistantindex = 0.0;
		//第一层矩阵一致性比率
		double consistantratio = 0.0;
		
		//准则层对目标层的相互权重矩阵
        //中间层对最高层
		String S = this.request.getParameter("A");
		
		//计算准则层对最高层的权重和一致性指数
		if (S != null) {
			//创建矩阵
			MatixcBean mb = new MatixcBean(S);
			//获取矩阵
			s = mb.getMatixc_double();
			//操作矩阵（归一化）
			level le = new level(s);
			weightvector1 = le.getWeightVector();	
			if (le.getLamuda() != 0) {
				lamuda = le.getLamuda();
			}		
			consistantindex = le.getConsistantIndex();			
			consistantratio = le.getConsistantRatio();
			String consistantratiomsg1 = "一致性比率 CR=" + consistantratio;
			String consistantratiomsg2 = le.isConsistant() ? ", 小于<10%，符合一致性要求" : 
				", 大于>10%，不符合一致性要求，请修改权重矩阵";
			String consistantratiomsg = consistantratiomsg1 + consistantratiomsg2;
			jsonObj.put("s", s);
			jsonObj.put("weightvector1", weightvector1);
			if (lamuda != 0.0) {
				jsonObj.put("lamuda", lamuda);
			} 
			if (consistantindex != 0.0) {
				jsonObj.put("consistantindex", consistantindex);
			}
			if (consistantratio != 0.0) {
				jsonObj.put("consistantratiomsg", consistantratiomsg);
			}
		}

		
		//分别计算底层对准则层的权重和一致性指数
		String[] S1 = this.request.getParameterValues("B[]"); 
		
		if (S1 != null) {
			//获取第二层矩阵数量
			int S1_len = S1.length;
			//第二层归一化矩阵特征值
			double [] lamuda1 = new double[S1_len];
			//第二层权重矩阵
			double [][] weightvector2 = new double[S1_len][];
			//第二层矩阵一致性指数
			double [] consistantindex1 = new double[S1_len];
			//第二层矩阵一致性比率
			double [] consistantratio1 = new double[S1_len];
			
			//创建第二层各个矩阵
			MatixcBean [] mb1 = new MatixcBean[S1_len];
			//第二层归一化矩阵
			double [][][] b = new double[S1_len][][];
			//矩阵操作（归一化）
			level [] le1 = new level[S1_len];
			//第二层权重矩阵
			Matrix [] m = new Matrix[S1_len];
			//矩阵一致性信息
			String [] consistantratiomsg_1 = new String[S1_len];
			String [] consistantratiomsg_2 = new String[S1_len];
			String [] _consistantratiomsg = new String[S1_len];
			
			for (int i=0; i<S1_len; i++) {
				lamuda1[i] = 0.0;
				mb1[i] = new MatixcBean(S1[i]);
				b[i] = mb1[i].getMatixc_double();
				le1[i] = new level(b[i]);	
				weightvector2[i] = le1[i].getWeightVector();
				if (le1[i].getLamuda() != 0.0) {
					lamuda1[i] = le1[i].getLamuda();
				}
				consistantindex1[i] = le1[i].getConsistantIndex();
				consistantratio1[i] = le1[i].getConsistantRatio();
				consistantratiomsg_1[i] = "一致性比率 CR=" + consistantratio1[i];
				consistantratiomsg_2[i] = le1[i].isConsistant() ? ", 小于<10%，符合一致性要求" : 
					", 大于>10%，不符合一致性要求，请修改权重矩阵";
				_consistantratiomsg[i] = consistantratiomsg_1[i] + consistantratiomsg_2[i];
				m[i] = new Matrix(weightvector2[i]);
			}
			
			Matrix tmp;
			if (S1_len > 1) {
				tmp = m[0];
				for (int i=1; i<S1_len; i++) {
					tmp = tmp.append(m[i]);
				}
			} else if (S1_len == 1) {
				tmp = m[0];
				tmp = tmp.append(m[1]);
			} else {
				tmp = m[0];
			}
			
			jsonObj.put("b", b);
			jsonObj.put("weightvector2", weightvector2);
			jsonObj.put("level1", le1);
			jsonObj.put("lamuda1", lamuda1);
			jsonObj.put("consistantindex1", consistantindex1);
			jsonObj.put("_consistantratiomsg", _consistantratiomsg);
			jsonObj.put("tmp", tmp);
		}
		
		jsonObj.put("success_calculate_result", true);
	}
}
