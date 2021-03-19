package code.webrtc.storage;

import code.webrtc.model.PeerB;

//single design pattern
public class PeerBStorage{
	private static PeerB peerB=new PeerB(); // eager instantiation
	private PeerBStorage() {
		
	}
	public static PeerB getInstance() {
		return peerB;
	}
}
