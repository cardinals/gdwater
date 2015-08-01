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
			// ��ȡÿ����Ⱦ���͵��Զ���ָ��
		case "get-index-of-pollutiontype":
			this.getIndexOfPollutionType();
			// �����һ�������ר�Ҵ��
		case "sava-ahp-scores":
			this.saveAHPScores();
			// ��ȡ�ϴ�ר�Ҵ��
		case "get-ahp-scores":
			this.getAHPScores();
			// ������
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
		//��һ���һ������
		double[][] s;
		//��һ���һ����������ֵ
		double lamuda = 0.0;
		//��һ��Ȩ�ؾ���
		double[] weightvector1;
		//��һ�����һ����ָ��
		double consistantindex = 0.0;
		//��һ�����һ���Ա���
		double consistantratio = 0.0;
		
		//׼����Ŀ�����໥Ȩ�ؾ���
        //�м�����߲�
		String S = this.request.getParameter("A");
		
		//����׼������߲��Ȩ�غ�һ����ָ��
		if (S != null) {
			//��������
			MatixcBean mb = new MatixcBean(S);
			//��ȡ����
			s = mb.getMatixc_double();
			//�������󣨹�һ����
			level le = new level(s);
			weightvector1 = le.getWeightVector();	
			if (le.getLamuda() != 0) {
				lamuda = le.getLamuda();
			}		
			consistantindex = le.getConsistantIndex();			
			consistantratio = le.getConsistantRatio();
			String consistantratiomsg1 = "һ���Ա��� CR=" + consistantratio;
			String consistantratiomsg2 = le.isConsistant() ? ", С��<10%������һ����Ҫ��" : 
				", ����>10%��������һ����Ҫ�����޸�Ȩ�ؾ���";
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

		
		//�ֱ����ײ��׼����Ȩ�غ�һ����ָ��
		String[] S1 = this.request.getParameterValues("B[]"); 
		
		if (S1 != null) {
			//��ȡ�ڶ����������
			int S1_len = S1.length;
			//�ڶ����һ����������ֵ
			double [] lamuda1 = new double[S1_len];
			//�ڶ���Ȩ�ؾ���
			double [][] weightvector2 = new double[S1_len][];
			//�ڶ������һ����ָ��
			double [] consistantindex1 = new double[S1_len];
			//�ڶ������һ���Ա���
			double [] consistantratio1 = new double[S1_len];
			
			//�����ڶ����������
			MatixcBean [] mb1 = new MatixcBean[S1_len];
			//�ڶ����һ������
			double [][][] b = new double[S1_len][][];
			//�����������һ����
			level [] le1 = new level[S1_len];
			//�ڶ���Ȩ�ؾ���
			Matrix [] m = new Matrix[S1_len];
			//����һ������Ϣ
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
				consistantratiomsg_1[i] = "һ���Ա��� CR=" + consistantratio1[i];
				consistantratiomsg_2[i] = le1[i].isConsistant() ? ", С��<10%������һ����Ҫ��" : 
					", ����>10%��������һ����Ҫ�����޸�Ȩ�ؾ���";
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
