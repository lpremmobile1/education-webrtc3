<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    </head>
    <body>
    <br>
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/jsp/webrtc/subject.jsp" />
	<h1 style="text-align: center;"><span class="badge bg-dark">Peer A</span></h1> <br>
	<%----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <%-------------------------------------------------------------------SECTION 1-------------------------------------------------------------------------------%>
    <%-----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <h3 style="background-color: orange; text-align:center; color: darkred; padding: 6px;">SECTION 1: Web RTC Signaling Test (With Spring Boot Backend and HTTP Protocol)</h3> <br>
    <div class="container-lg">
    <%-------------------------------------------------STEP 1.1-------------------------------------------------------%>
    <button onclick="generateAndStore()" class="btn btn-info">Generate and Store Offer SDP &nbsp;&nbsp;<span class="badge bg-secondary">Step 1.1</span></button><br> <br>
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label">STUN and TURN configurations can be updated below</label>
      <textarea class="form-control" id="exampleFormControlTextarea1" rows="5">${stunAndTurnConfig}</textarea>
   </div>
    <p>Generated offer SDP will be shown below </p>
    <div id="offerSDP" style="background-color: rgb(245, 245, 245);width: 70vw;height: 150px; overflow: scroll;"></div> <br>
    <h5 style="background-color: purple;text-align:center; color: white;" id="storeOfferSDPStatus"></h5>
    <h5 style="background-color: rgb(245, 245, 245); text-align:center; color: green;" id="Step1_1status"></h5>
    <p>The next step i.e. <span class="badge bg-secondary">Step 1.2</span> and  <span class="badge bg-secondary">Step 1.3</span> has to be performed at Peer B </p>
    <hr style="height: 8px;background: fuchsia;">
    <br>
    <%-------------------------------------------------STEP 1.4-------------------------------------------------------%>
    <button onclick="getConnection()" class="btn btn-info">Refresh and Get Answer &nbsp;&nbsp;<span class="badge bg-secondary">Step 1.4</span></button>
    <div id="getConnectionDiv">
    </div>
    <h5>Connection Status : <span id="connectionStatus" class="badge bg-success">Not Connected</span></h5>
    </div>
    <br>
    <%----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <%-------------------------------------------------------------------SECTION 2-------------------------------------------------------------------------------%>
    <%-----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <h3 style="background-color: orange; text-align:center; color: darkred; padding: 6px;">SECTION 2: Web RTC Chat Test</h3> <br>
    <%-------------------------------------------------STEP 2.1-------------------------------------------------------%>
    <div class="container-lg">
    <p>Received Messages will be shown below </p>
    <div id="receivedMessages" style="background-color: rgb(245, 245, 245);width: 70vw;height: 150px; overflow: scroll;"></div> <br>
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label">Type your message here.</label>
      <textarea class="form-control" id="sendMessage" rows="3"></textarea>
    </div>
      <button onclick="sendMessage()" class="btn btn-info">Send Message</button>
    </div> 
    <%----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <%-------------------------------------------------------------------SECTION 3-------------------------------------------------------------------------------%>
    <%-----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <h3 style="background-color: orange; text-align:center; color: darkred; padding: 6px;">SECTION 3: Web RTC Video and Audio Test (Under Development)</h3> <br>
    <div class="container d-flex justify-content-start">
    <div class="pe-5">
    <p>Local Video </p>
    <video width="40vw;" height="40vh;"  id="localVideo" autoplay style="border-style: solid;border-color: gray;"></video> <br>
    </div>
    
    <div>
    <p>Remote Video </p> 
    <video width="40vw;" height="40vh;"  id="remoteVideo" autoplay style="border-style: solid;border-color: gray;"></video> <br>
    </div>
    </div>
    
    <div class="container d-flex justify-content-start">
    <button type="button" onclick="showLocalVideo()" id="btnShowCamera" >Show Local Video</button>
    
    <button type="button" onclick="showAndSendMyMedia()" id="btnShowCamera" >Show And Send My Media</button>
    
    </div>
    
<script type="text/javascript">
/*-------------------------------------------------Section 1-------------------------------------------------------*/
var configuration = {
	    "iceServers" : [ {
	        "url" : "stun:stun2.1.google.com:19302"
	    } ]
	}; 
var localConnection = new RTCPeerConnection(configuration);

const sendChannel = localConnection.createDataChannel("sendChannel");
	 sendChannel.onmessage =e => { console.log("Messsage from Other Peer(i.e. Peer B)."  + e.data );$("#receivedMessages").append("<span class=\"badge bg-primary\">Peer B</span> &nbsp;&nbsp; "+ e.data+"<br>");}
	 sendChannel.onopen = e => console.log("open!!!!");
	 sendChannel.onclose =e => console.log("closed!!!!!!");

function generateAndStore(){
	 localConnection.onicecandidate = e =>  {
	 console.log(" NEW ice candidnat!! on localconnection reprinting SDP " );
	 $("#offerSDP").append("<p style='color:purple;'>rewriting SDP from localConnection for each new Ice Canditate</p>");
	 console.log(JSON.stringify(localConnection.localDescription));
	 $("#offerSDP").append(JSON.stringify(localConnection.localDescription));
	 storeOfferSDP(JSON.stringify(localConnection.localDescription));
	}




	localConnection.createOffer().then(o => localConnection.setLocalDescription(o) )

	}
	
function storeOfferSDP(offerSDP){
	$.post( "${pageContext.request.contextPath}/storeoffersdp", {offerSDP: offerSDP })
	  .done(function( data ) {
		  $("#storeOfferSDPStatus").html(data);
		  $("#Step1_1status").html("Step1.1 has been completed successfully.");
	  });
}	



function getConnection(){
	$.get( "${pageContext.request.contextPath}/getconnection")
	  .done(function( data ) {
		  $("#getConnectionDiv").html(data);
	  });
}

//on enter listener
var input = document.getElementById("sendMessage");

input.addEventListener("keyup", function(event) {
  if (event.keyCode === 13) {
    // Cancel the default action, if needed
    event.preventDefault();
    // Trigger the button element with a click
    //document.getElementById("myBtn").click();
    sendMessage();
  }
});
////////////////////////////start up code for video to remote location
startUp();
async function startUp(){
const constraints = {'video': true, 'audio': true};
const localStream = await navigator.mediaDevices.getUserMedia(constraints);
localStream.getTracks().forEach(track => {
	localConnection.addTrack(track, localStream);
});
}
////////////////////////////remote stream
const remoteStream =new MediaStream();
const remoteVideo = document.querySelector('#remoteVideo');
remoteVideo.srcObject = remoteStream;

localConnection.addEventListener('track', async (event) => {
    remoteStream.addTrack(event.track, remoteStream);
});
////////////////////////////////////////////////
/*-------------------------------------------------Section 2-------------------------------------------------------*/
function sendMessage(){
	var message=document.getElementById("sendMessage").value;
	sendChannel.send(message);
	$("#receivedMessages").append("<span class=\"badge bg-dark\">You</span> &nbsp;&nbsp; "+message+"<br>");
	document.getElementById("sendMessage").value="";
}
/*-------------------------------------------------Section 3-------------------------------------------------------*/
function GetUserMedia(){
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia
                    || navigator.mozGetUserMedia || navigator.msGetUserMedia;
    return navigator.getUserMedia;
}
 
function showLocalVideo(){
    var localMedia = GetUserMedia();
    if(localMedia){        
        navigator.getUserMedia({video: true, audio: false}, function(stream){
     
            /*document.getElementsByTagName("video")[0].src = window.URL.createObjectURL(stream);*/
            document.getElementsByTagName("video")[0].srcObject = stream;
     
        }, function(error){
            console.log("There was an error in GetUserMedia!!!");
        });
    }
}
/*************************************************Section 3 part2*****************************************************/
function showAndSendMyMedia(){
	alert('hello');
}
</script>        
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    </body>
</html>