package com.gdwater.service;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.gdwater.domain.Index;
import com.gdwater.domain.IndexSelect;
import com.gdwater.domain.PollutionType;
import com.gdwater.util.HibernateUtil;

import net.sf.json.JSONObject;

public class IndexDBService {

	private HttpServletRequest request;
	private JSONObject jsonObj;
	private String serviceType = null;

	public IndexDBService() {

	};

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

		switch (this.serviceType) {
			// 用户自定义添加指标
		case "add-index":
			this.addIndex();
			// 获取指标库所有指标信息
		case "get-all-index":
			this.getAllIndex();
			// 删除选中指标
		case "delete-checked-index":
			this.deleteCheckedIndex();
			// 添加污染类型
		case "add-pollutiontype":
			this.addPollutionType();
			// 删除污染类型
		case "delete-pollution-type":
			this.deletePollutionType();
			// 获取所有的污染类型
		case "get-all-pollution-type":
			this.getAllPollutionType();
			// 获取用户自定义指标
		case "get-checked-index":
			this.getCheckedIndex();
			// 保存用户自定义分配的污染类型指标
		case "save-selected-index":
			this.saveSelectedIndex();
			// 获取指标阈值
		case "get-index-thre":
			this.getIndexThre();
			// 保存指标阈值
		case "save-index-thre":
			this.saveIndexThre();
		default:
			break;
		}
	}

	private void addIndex() {
		String index_name = this.request.getParameter("index_name");
		String index_type = this.request.getParameter("index_class");
		UUID uuid = UUID.randomUUID();
		String index_id = uuid.toString();
		
		if (index_name != null && index_type != null && index_id != null) {
			Index index = new Index();
			index.setIndexId(index_id);
			index.setIndexName(index_name);
			index.setIndexType(index_type);
			HibernateUtil.save(index);
		}		

		this.jsonObj.put("success_add_index", true);
		this.jsonObj.put("message_add_index", "已成功添加指标");
	}

	private void getAllIndex() {
		String hql = "from Index";

		List<Index> list = HibernateUtil.executeQuery(hql, null);

		this.jsonObj.put("index_list", list);
		this.jsonObj.put("success_get_all_index", true);
	}

	private void deleteCheckedIndex() {
		String index_name = this.request.getParameter("index_name");
		String index_type = this.request.getParameter("index_type");

		if (index_name != null && index_type != null) {
			String hql = "delete from Index index where index.indexName = ? and index.indexType = ?";
			String parameters[] = { index_name, index_type };

			HibernateUtil.excuteUpdate(hql, parameters);
		}

		this.jsonObj.put("success_delete_checked_index", true);
		this.jsonObj.put("message_delete_checked_index", "被选中指标已被成功删除");
	}
	
	private void addPollutionType() {
		String pollutiontypename = this.request.getParameter("pollutiontypename");
		
		if (pollutiontypename != null) {
			PollutionType pollutiontype = new PollutionType();
			pollutiontype.setPollutionType(pollutiontypename);
			
			HibernateUtil.save(pollutiontype);
		}			
		
		this.jsonObj.put("success_add_pollutiontype", true);
		this.jsonObj.put("message_add_pollutiontype", "已成功添加污染类型");
	}
	
	private void deletePollutionType() {
		String pollutiontype = this.request.getParameter("pollutiontype");
		
		String hql = "delete from PollutionType pt where pt.pollutionType = ?";
		String parameters[] = {pollutiontype};
		
		HibernateUtil.excuteUpdate(hql, parameters);
		
		this.jsonObj.put("success_delete_pollution_type", true);
		this.jsonObj.put("message_delete_pollution_type", "被选中的污染类型已被成功删除");
	}

	private void getAllPollutionType() {
		String hql = "from PollutionType";

		List<PollutionType> list = HibernateUtil.executeQuery(hql, null);
		int len = list.size();
		String[] pollutiontype = new String[len];
		int count = 0;
		for (PollutionType pt : list) {
			pollutiontype[count] = pt.getPollutionType();
			count++;
		}

		this.jsonObj.put("success_get_all_pollution_type", true);
		this.jsonObj.put("pollutiontypeall", pollutiontype);
	}

	private void getCheckedIndex() {
		String pollutiontype = this.request.getParameter("pollutiontype");
		
		String hql = "from IndexSelect indexselect where indexselect.pollutionType = ?";
		String parameters[] = {pollutiontype};
		List<IndexSelect> list = HibernateUtil.executeQuery(hql, parameters);
		int selectedindexsize = list.size();
		
		String[][] selectedindex = new String[selectedindexsize][4];
		int count = 0;

		for (IndexSelect indexselect : list) {
			selectedindex[count][0] = indexselect.getIndexId();
			selectedindex[count][1] = indexselect.getIndexName();
			selectedindex[count][2] = indexselect.getPollutionType();
			selectedindex[count][3] = indexselect.getThreshold().toString();
			count++;
		}

		this.jsonObj.put("success_get_checked_index", true);
		this.jsonObj.put("selectedindex", selectedindex);
	}

	private void saveSelectedIndex() {	
		String pollutiontype = this.request.getParameter("pollutiontype");
		String [] selectedindex = this.request
				.getParameterValues("selectedindex[]");

		int len = 0;
		if (selectedindex != null && pollutiontype != null) {
			String hql = "delete IndexSelect indexselect where indexselect.pollutionType = ?";
			String parameters[] = {pollutiontype};
			HibernateUtil.excuteUpdate(hql, parameters);
			
			len = selectedindex.length;
			String [] index_id_select = new String[len];
			String [] index_name_select = new String[len];

			for (int i = 0; i < len; i++) {
				index_name_select[i] = selectedindex[i];
				
				String hql1 = "select indexId from Index index where index.indexName = ?";
				String parameters1[] = { index_name_select[i] };

				List<Index> list1 = HibernateUtil.executeQuery(hql1,
						parameters1);
				for (Object obj : list1) {
					index_id_select[i] = obj.toString();
				}
			}	
			
			for (int i = 0; i < len; i++) {
				IndexSelect indexselect = new IndexSelect();
				indexselect.setIndexId(index_id_select[i]);
				indexselect.setIndexName(index_name_select[i]);
				indexselect.setPollutionType(pollutiontype);
				
				HibernateUtil.save(indexselect);
			}
			
			this.jsonObj.put("success_save_selected_index", true);
		}
	}

	private void saveIndexThre() {
		String index_name_select = this.request
				.getParameter("index_name_select");
		String pollution_type_select = this.request
				.getParameter("pollution_type_select");
		String threshold_s = this.request.getParameter("threshold");
		double threshold_d = 0.0;
		if (threshold_s != null) {
			threshold_d = Double.parseDouble(threshold_s);
		}

		Session session = HibernateUtil.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Query query = session
					.createQuery("update IndexSelect indexselect set indexselect.threshold = ? where indexselect.indexName = ? and indexselect.pollutionType = ?");
			query.setDouble(0, threshold_d);
			query.setString(1, index_name_select);
			query.setString(2, pollution_type_select);
			query.executeUpdate();
			session.flush();
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw new RuntimeException(e.getMessage());
		} finally {
			if (session != null && session.isOpen()) {
				session.clear();
				session.close();
			}
		}

		jsonObj.put("success_save_index_thre", true);
	}

	private void getIndexThre() {
		String hql = "from IndexSelect";
		int len = 0, count = 0;
		List<IndexSelect> list = HibernateUtil.executeQuery(hql, null);
		len = list.size();

		String[] indexname = new String[len];
		String[] pollutiontype = new String[len];
		double[] threshold = new double[len];

		for (IndexSelect indexselect : list) {
			indexname[count] = indexselect.getIndexName();
			pollutiontype[count] = indexselect.getPollutionType();
			if (indexselect.getThreshold() != null) {
				threshold[count] = indexselect.getThreshold();
			} else {
				threshold[count] = 0.0;
			}
			
			count++;
		}

		jsonObj.put("success_get_index_thre", true);
		jsonObj.put("indexname", indexname);
		jsonObj.put("pollutiontype", pollutiontype);
		jsonObj.put("indexthreshold", threshold);
	}
}
