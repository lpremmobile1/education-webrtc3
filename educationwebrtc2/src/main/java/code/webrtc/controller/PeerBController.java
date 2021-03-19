package code.webrtc.controller;

import java.time.LocalDateTime;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import code.webrtc.model.PeerA;
import code.webrtc.model.PeerB;
import code.webrtc.storage.PeerAStorage;
import code.webrtc.storage.PeerBStorage;

@Controller
public class PeerBController implements CommandLineRunner{
	PeerA peerA=PeerAStorage.getInstance();
	PeerB peerB=PeerBStorage.getInstance();
	
	@RequestMapping(value = "/peerb", method = RequestMethod.GET)
	public String yourMethodeName4(Model model) {
		model.addAttribute("offerSDP", peerA.getOfferSDP());
		model.addAttribute("stunAndTurnConfig", peerB.getStunAndTurnConfig());
		return "/webrtc/peerb";
	}
	
	@RequestMapping(value = "/storeanswersdp", method = RequestMethod.POST)
	@ResponseBody
	public String yourMethodeName6(Model model, @RequestParam("answerSDP") String answerSDP) {
		
		peerB.setAnswerSDP(answerSDP);
		
		return "Answer SDP has been stored successfully in backend on "+LocalDateTime.now();
	}
	@RequestMapping(value = "/refreshandgetoffer", method = RequestMethod.GET)
	@ResponseBody
	public String yourMethodeName7(Model model) {
		return peerA.getOfferSDP();
	}
	
	//test
	@RequestMapping(value = "/getoffer", method = RequestMethod.GET)
	@ResponseBody
	public String yourMethodeName6(Model model) {
		return peerA.getOfferSDP();
	}

	@Override
	public void run(String... args) throws Exception {
		PeerBStorage.getInstance().setStunAndTurnConfig("var configuration = {\n"
				+ "	    \"iceServers\" : [ {\n"
				+ "	        \"url\" : \"stun:stun2.1.google.com:19302\"\n"
				+ "	    } ]\n"
				+ "	}; ");
		PeerBStorage.getInstance().setAnswerSDP("{\"type\":\"answer should be updated\"}");
		
	}
}