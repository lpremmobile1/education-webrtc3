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
public class PeerAController implements CommandLineRunner{
	PeerA peerA=PeerAStorage.getInstance();
	PeerB peerB=PeerBStorage.getInstance();
	
	@RequestMapping(value = "/peera", method = RequestMethod.GET) 
	public String yourMethodeName3(Model model) {
//		model.addAttribute("answerSDP", peerB.getAnswerSDP());
		model.addAttribute("stunAndTurnConfig", peerA.getStunAndTurnConfig());
		return "/webrtc/peera";
	}
	
	@RequestMapping(value = "/storeoffersdp", method = RequestMethod.POST)
	@ResponseBody
	public String yourMethodeName5(Model model, @RequestParam("offerSDP") String offerSDP) {
		
		peerA.setOfferSDP(offerSDP);
		return "offer SDP has been stored successfully in backend on "+LocalDateTime.now();
	}
	
	@RequestMapping(value = "/getconnection", method = RequestMethod.GET)
	public String yourMethodeName8(Model model) {
		model.addAttribute("answerSDP", peerB.getAnswerSDP());
		return "/webrtc/getconnection";
	}
	@RequestMapping(value = "/refreshandgetanswer", method = RequestMethod.GET)
	@ResponseBody
	public String yourMethodeName9(Model model) {
		return peerB.getAnswerSDP();
	}
	//get answer
	@RequestMapping(value = "/getanswer", method = RequestMethod.GET)
	@ResponseBody
	public String yourMethodeName7(Model model) {
		return peerB.getAnswerSDP();
	}

	@Override
	public void run(String... args) throws Exception {
		PeerAStorage.getInstance().setStunAndTurnConfig("var configuration = {\n"
				+ "	    \"iceServers\" : [ {\n"
				+ "	        \"url\" : \"stun:stun2.1.google.com:19302\"\n"
				+ "	    } ]\n"
				+ "	}; ");
//		System.out.println("--"+PeerAStorage.getInstance().getStunAndTurnConfig());
		
	}
}