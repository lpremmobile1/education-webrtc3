package code.webrtc.storage;

import code.webrtc.model.PeerA;

//single design pattern
public class PeerAStorage {
	private static PeerA peerA=new PeerA(); //eager instantiation
	private PeerAStorage() {
	}
	public static PeerA getInstance() {
		return peerA;
	}
	
}
