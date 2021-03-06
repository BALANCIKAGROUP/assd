package com.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.app.entities.CrmCampaignStatus;


@RestController
@RequestMapping("/")
public class CrmLeadStatusController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead_status/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllLeadStatus(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead_status/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead_status/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addStatus(@RequestBody CrmCampaignStatus status){
		
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead_status/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead_status/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> LeadStatusID(@PathVariable("id") String id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead_status/list/"+id, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead_status/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateStatus(@RequestBody CrmCampaignStatus status){
		
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead_status/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead_status/remove/{statusID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteStatus(@PathVariable("statusID") String statusID){
		
		HttpEntity<String> request = new HttpEntity<String>(statusID,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead_status/remove/"+statusID, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
