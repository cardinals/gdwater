package com.gdwater.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.gdwater.service.AHPDBService;
import com.gdwater.service.AlarmDBService;
import com.gdwater.service.IndexDBService;
import com.gdwater.service.MonitorDBService;
import com.gdwater.service.SimulationDBService;

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
				indexdbservice.setJsonObj(jsonObj);
				indexdbservice.setRequest(request);
				indexdbservice.serviceProcess();				
				jsonObj = indexdbservice.getJsonObj();
			case "ahp-db-service":
				AHPDBService ahpdbservice = new AHPDBService();
				ahpdbservice.setJsonObj(jsonObj);
				ahpdbservice.setRequest(request);
				ahpdbservice.serviceProcess();
				jsonObj = ahpdbservice.getJsonObj();
			case "simulation-db-service":
				SimulationDBService simulationdbservice = new SimulationDBService();
				simulationdbservice.setJsonObj(jsonObj);
				simulationdbservice.setRequest(request);
				simulationdbservice.serviceProcess();
				jsonObj = simulationdbservice.getJsonObj();
			case "alarm-db-service":
				AlarmDBService alarmdbservice = new AlarmDBService();
				alarmdbservice.setJsonObj(jsonObj);
				alarmdbservice.setRequest(request);
				alarmdbservice.serviceProcess();
				jsonObj = alarmdbservice.getJsonObj();
			case "monitor-db-service":
				MonitorDBService monitordbservice = new MonitorDBService();
				monitordbservice.setJsonObj(jsonObj);
				monitordbservice.setRequest(request);
				monitordbservice.serviceProcess();
				jsonObj = monitordbservice.getJsonObj();
			default:
				break;
		}	
		
		response.getWriter().write(jsonObj.toString());
		jsonObj.clear();		
	}

}
