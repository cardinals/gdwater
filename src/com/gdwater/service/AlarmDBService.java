package com.gdwater.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.gdwater.domain.PollutionType;
import com.gdwater.domain.IndexSelect;
import com.gdwater.util.HibernateUtil;

import net.sf.json.JSONObject;

public class AlarmDBService {
	private HttpServletRequest request;
	private JSONObject jsonObj;
	private String serviceType = null;
	
	public AlarmDBService() {
		
	}
	
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public JSONObject getJsonObj() {
		return this.jsonObj;
	}

	public void setJsonObj(JSONObject obj) {
		this.jsonObj = obj;
	}
	
	public void serviceProcess() {
		this.serviceType = this.request.getParameter("servicetype");
	
		switch(this.serviceType) {
			// 获取污染类型
			case "get-alarm-pollution-type":
				this.getAlarmPollutionType();
			// 根据污染类型获取指标
			case "get-alarm-index":
				this.getAlarmIndex();
			default:
				break;
		}
	}
	
	public void getAlarmPollutionType() {
		String hql = "from PollutionType";
		
		List<PollutionType> list = HibernateUtil.executeQuery(hql, null);
		int len = list.size();
		String[] pollutiontype = new String[len];
		int count = 0;
		for (PollutionType pt : list) {
			pollutiontype[count] = pt.getPollutionType();
			count++;
		}		
		
		this.jsonObj.put("success_get_alarm_pollution_type", true);
		this.jsonObj.put("alarmpollutiontype", pollutiontype);
	}
	
	public void getAlarmIndex() {
		String pollutiontype = this.request.getParameter("pollutiontype");
		
		if (pollutiontype != null) {
			String hql = "from IndexSelect indexselect where indexselect.pollutionType = ?";
			String [] parameters = {pollutiontype};
			
			List<IndexSelect> list = HibernateUtil.executeQuery(hql, parameters);
			String [] index = new String[list.size()];
			int count = 0;
			for (IndexSelect indexselect : list) {
				index[count] = indexselect.getIndexName();
				count ++;
			}
			
			this.jsonObj.put("success_get_alarm_index", true);
			this.jsonObj.put("alarmindex", index);
		}
	}
}
