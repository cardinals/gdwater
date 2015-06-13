package com.gdwater.service;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.gdwater.domain.Index;
import com.gdwater.domain.IndexSelect;
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
	
	public void setJsonObj() {
		this.jsonObj = new JSONObject();
	}

	public void serviceProcess() {
		serviceType = this.request.getParameter("servicetype");

		switch (serviceType) {
		// 用户自定义添加指标
		case "add-index":
			this.addIndex();
			// 获取指标库所有指标信息
		case "get-all-index":
			this.getAllIndex();
			// 删除选中指标
		case "delete-checked-index":
			this.deleteCheckedIndex();
			// 获取用户自定义指标
		case "get-checked-index":
			this.getCheckedIndex();
			// 保存自定义指标
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

		Index index = new Index();
		index.setIndexId(index_id);
		index.setIndexName(index_name);
		index.setIndexType(index_type);
		HibernateUtil.save(index);

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

	private void getCheckedIndex() {
		String hql = "from IndexSelect";

		List<IndexSelect> list = HibernateUtil.executeQuery(hql, null);
		int len = list.size();
		String[][] dataset = new String[len][3];
		int count = 0;

		for (IndexSelect indexselect : list) {
			dataset[count][0] = indexselect.getIndexId();
			dataset[count][1] = indexselect.getIndexName();
			dataset[count][2] = indexselect.getIndexType();
			count++;
		}
		
		this.jsonObj.put("success_get_checked_index", true);
		this.jsonObj.put("dataset_checked_index", dataset);
	}

	private void saveSelectedIndex() {
		String[] index_name_select = this.request
				.getParameterValues("index_name_select[]");
		String[] index_type_select = this.request
				.getParameterValues("index_type_select[]");

		int len = 0;
		if (index_name_select != null) {
			len = index_name_select.length;
			String[] index_id_select = new String[len];

			for (int i = 0; i < len; i++) {
				String hql1 = "select indexId from Index index where index.indexName = ? and index.indexType = ?";
				String parameters1[] = { index_name_select[i],
						index_type_select[i] };

				List<Index> list1 = HibernateUtil.executeQuery(hql1,
						parameters1);
				for (Object obj : list1) {
					index_id_select[i] = obj.toString();
				}
			}

			String hql2 = "from IndexSelect indexselect";
			List<IndexSelect> list2 = HibernateUtil.executeQuery(hql2, null);
			
			if (list2.size() > 0) {
				for (IndexSelect indexselect : list2) {
					Boolean flag = false;
					for (int i = 0; i < len; i++) {
						System.out.println(indexselect.getIndexId().length());
						System.out.println(index_id_select[i].length());
						if (indexselect.getIndexId().toString().equals(index_id_select[i].toString())) {
							flag = true;
						}
					}
					
					if (!flag) {
						String c_index_id_select = indexselect.getIndexId();

						String hql3 = "delete from IndexSelect indexselect where indexselect.indexId = ?";
						String parameters3[] = { c_index_id_select };

						HibernateUtil.excuteUpdate(hql3, parameters3);
					}
				}
			}			

			for (int i = 0; i < len; i++) {
				String hql4 = "from IndexSelect indexselect where indexselect.indexId = ?";
				String parameters4[] = { index_id_select[i] };
				List<IndexSelect> list4 = HibernateUtil.executeQuery(hql4,
						parameters4);
				
				if (list4.size() == 0) {
					IndexSelect indexselect = new IndexSelect();
					indexselect.setIndexId(index_id_select[i]);
					indexselect.setIndexName(index_name_select[i]);
					indexselect.setIndexType(index_type_select[i]);

					HibernateUtil.save(indexselect);
				}
			}

			this.jsonObj.put("success_save_selected_index", true);
			this.jsonObj.put("message_save_selected_index", "自定义指标已保存成功");
		}
	}
	
	private void saveIndexThre() {
		String index_name_select = this.request.getParameter("index_name_select");
		String index_type_select = this.request.getParameter("index_type_select");
		String threshold_s = this.request.getParameter("threshold");
		double threshold_d = 0.0;
		if (threshold_s != null) {
			threshold_d = Double.parseDouble(threshold_s);
		}
			
		Session session = HibernateUtil.openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Query query = session.createQuery("update IndexSelect indexselect set indexselect.threshold = ? where indexselect.indexName = ? and indexselect.indexType = ?");
			query.setDouble(0, threshold_d);
			query.setString(1, index_name_select);
			query.setString(2, index_type_select);
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
		for (IndexSelect indexselect:list) {
			len ++;
		}
		
		String [] indexname = new String[len];
		String [] indextype = new String[len];
		double [] threshold = new double[len];
		
		for (IndexSelect indexselect:list) {
			indexname[count] = indexselect.getIndexName();
			indextype[count] = indexselect.getIndexType();
			threshold[count] = indexselect.getThreshold();
			count ++;
		}
		
		jsonObj.put("success_get_index_thre", true);
		jsonObj.put("indexname", indexname);
		jsonObj.put("indextype", indextype);
		jsonObj.put("indexthreshold", threshold);
	}
}
