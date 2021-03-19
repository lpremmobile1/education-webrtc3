package code.webrtc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class WebRtcController {

	
	@RequestMapping(value = "/webrtc/index", method = RequestMethod.GET)
	public String yourMethodeName1(Model model) {
		return "/webrtc/index";
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String yourMethodeName2(Model model) {
		return "/webrtc/home";
	}
	
	
	

	
	
	
	
	
	
	

	
	
}