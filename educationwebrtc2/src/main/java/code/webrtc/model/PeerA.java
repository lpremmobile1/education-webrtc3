package code.webrtc.model;

public class PeerA {
	private String offerSDP;
	private String stunAndTurnConfig;

	public String getOfferSDP() {
		return offerSDP;
	}

	public void setOfferSDP(String offerSDP) {
		this.offerSDP = offerSDP;
	}

	public String getStunAndTurnConfig() {
		return stunAndTurnConfig;
	}

	public void setStunAndTurnConfig(String stunAndTurnConfig) {
		this.stunAndTurnConfig = stunAndTurnConfig;
	}
	
}
