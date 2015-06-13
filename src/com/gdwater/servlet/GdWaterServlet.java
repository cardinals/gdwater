package com.gdwater.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.gdwater.service.IndexDBService;

/**
 * Servlet implementation class GdWaterServlet
 */
@WebServlet(description = "This is gdwater web app servlet.", urlPatterns = { "/GdWaterServlet" })
public class GdWaterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GdWaterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		this.doPost(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		JSONObject jsonObj = new JSONObject();
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=utf-8");
		String servicename = request.getParameter("servicename");
		
		switch(servicename) {
			case "index-db-service":
				IndexDBService indexdbservice = new IndexDBService();	
				indexdbservice.setJsonObj();
				indexdbservice.setRequest(request);
				indexdbservice.serviceProcess();				
				jsonObj = indexdbservice.getJsonObj();
			default:
				break;
		}	
		
		response.getWriter().write(jsonObj.toString());
		jsonObj.clear();		
	}

}
