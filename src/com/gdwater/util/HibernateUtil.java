package com.gdwater.util;

import java.util.List;

import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;

final public class HibernateUtil {
	
	private static Configuration cfg = null;
	
	private static ServiceRegistry sr = null;
	
	private static SessionFactory sessionFactory = null;
	
	//使用线程局部模式
	private static ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();
	
	private HibernateUtil() {};
	
	static {
		cfg = new Configuration().configure();
		sr = new ServiceRegistryBuilder().applySettings(cfg.getProperties()).buildServiceRegistry();
		sessionFactory = cfg.buildSessionFactory(sr);
	}
	
	public static Session openSession() {
		return sessionFactory.openSession();
	}
	
	public static Session getCurrentSession() {
		Session session = threadLocal.get();
		
		if (session == null) {
			session = sessionFactory.openSession();
			threadLocal.set(session);
		}
		
		return session;
	}
	
	//统一添加方法
	public static void save(Object obj) {
		Session session = null;
		Transaction tx = null;
		
		try {
			
			session = openSession();
			tx = session.beginTransaction();
			session.save(obj);
			session.flush();
			tx.commit();
			
		} catch(Exception e) {
			
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
	}
	
	//统一修改删除方法
	public static void excuteUpdate(String hql, String [] parameters) {
		Session session = null;
		Transaction tx = null;
		
		try {
			
			session = openSession();
			tx = session.beginTransaction();
			Query query = session.createQuery(hql);
			
			if (parameters !=null && parameters.length > 0) {
				for (int i=0; i<parameters.length; i++) {
					query.setString(i, parameters[i]);
				}
			}
			
			query.executeUpdate();
			session.flush();
			tx.commit();
			
		} catch(Exception e) {
			
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
	}
	
	//统一查询方法
	@SuppressWarnings("unchecked")
	public static <T> List<T> executeQuery(String hql, String [] parameters) {
		Session session = null;
		List<T> list = null;
		
		try {
			
			session = openSession();
			Query query = session.createQuery(hql);
			
			if (parameters !=null && parameters.length > 0) {
				for (int i=0; i<parameters.length; i++) {
					query.setString(i, parameters[i]);
				}
			}
			
			list = query.list();
			session.flush();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
			
		} finally {
			
			if (session != null && session.isOpen()) {
				session.clear();
				session.close();
			}
			
		}
		
		return list;		
		
	}
}
