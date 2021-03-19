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
     <jsp:include page="${pageContext.request.contextPath}/WEB-INF/jsp/webrtc/subject.jsp" />
     <h1 style="text-align: center;"><span class="badge bg-dark">Peer B</span></h1> <br>
    <%----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <%-------------------------------------------------------------------SECTION 1-------------------------------------------------------------------------------%>
    <%-----------------------------------------------------------------------------------------------------------------------------------------------------------%>
     <h3 style="background-color: orange; text-align:center; color: darkred; padding: 6px;">SECTION 1:  Web RTC Signaling Test(With Spring Boot Backend and HTTP Protocol)</h3> <br>
    <%-------------------------------------------------STEP 1.2-------------------------------------------------------%>
    <div class="container-lg">
    <form action="${pageContext.request.contextPath}/peerb">
    <button type="submit" class="btn btn-info" onclick="refreshAndGetOffer()">Refresh and Get Offer &nbsp;&nbsp;<span class="badge bg-secondary">Step 1.2</span></button>
    </form>
    
    <p>Offer SDP from <span class="badge bg-dark">Peer A</span> will be shown below </p>
	<div id="offerSDP" style="background-color: rgb(245, 245, 245); width: 70vw;height: 150px; overflow: scroll;">${offerSDP}</div> <br>
	<h5 style="background-color: rgb(245, 245, 245);text-align:center; color: green;" id="step1_2status"></h5>
    <hr style="height: 8px;background: fuchsia;">
    <%-------------------------------------------------STEP 1.3-------------------------------------------------------%>
    <button  class="btn btn-info" onclick="generateAndStore()">generate and store Answer SDP&nbsp;&nbsp;<span class="badge bg-secondary">Step 1.3</span></button> <br><br>
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label">STUN and TURN configurations can be updated below</label>
      <textarea class="form-control" id="exampleFormControlTextarea1" rows="5">${stunAndTurnConfig}</textarea>
   </div>
    <p>Generated Answer SDP will be shown below </p>
    <div id="answerSDP" style="background-color: rgb(245, 245, 245); width: 70vw;height: 150px; overflow: scroll;"></div> <br>
    <h5 style="background-color: purple;text-align:center; color: white;" id="storeAnswerSDPStatus"></h5>
    <h5 style="background-color: rgb(245, 245, 245);text-align:center; color: green;" id="step1_3status"></h5>
    </div>
    <br>
    <%----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <%-------------------------------------------------------------------SECTION 2-------------------------------------------------------------------------------%>
    <%-----------------------------------------------------------------------------------------------------------------------------------------------------------%>
    <h3 style="background-color: orange; text-align:center; color: darkred; padding: 6px;">SECTION 2: Web RTC Chat Test</h3> <br>
	<%----------------------------------------------------------STEP 2.1-------------------------------------------------------%>
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
    <video width="150px;" height="200px"  id="localVideo" autoplay style="border-style: solid;border-color: gray;"></video> <br>
    </div>
    
    <div>
    <p>Remote Video </p> 
    <video width="150px;" height="200px"  id="remoteVideo" autoplay style="border-style: solid;border-color: gray;"></video> <br>
    </div>
    </div>
    
    <div class="container d-flex justify-content-start">
    <button type="button" onclick="showLocalVideo()" id="btnShowCamera" >Show Local Video</button>
    
    <button type="button" onclick="showAndSendMyMedia()" id="btnShowCamera" >Show And Send My Media</button>
    
    </div>

<script type="text/javascript">

var configuration = {
	    "iceServers" : [ {
	        "url" : "stun:stun2.1.google.com:19302"
	    } ]
	}; 
const remoteConnection = new RTCPeerConnection(configuration);

remoteConnection.ondatachannel= e => {

      const receiveChannel = e.channel;
      receiveChannel.onmessage =e =>  {console.log("messsage received!!!"  + e.data );$("#receivedMessages").append("<span class=\"badge bg-primary\">Peer A</span> &nbsp;&nbsp; "+ e.data+"<br>");}
      receiveChannel.onopen = e => console.log("open!!!!");
      receiveChannel.onclose =e => console.log("closed!!!!!!");
      remoteConnection.channel = receiveChannel;

}
////////////////////////////start up code for video to remote to remote location
startUp();
	 async function startUp(){
		 //alert('hello');
	 const constraints = {'video': true, 'audio': true};
	 const localStream = await navigator.mediaDevices.getUserMedia(constraints);
	 localStream.getTracks().forEach(track => {
		 remoteConnection.addTrack(track, localStream);
	 });
	 }

////////////////////////////remote stream
const remoteStream =new MediaStream();
const remoteVideo = document.querySelector('#remoteVideo');
remoteVideo.srcObject = remoteStream;

remoteConnection.addEventListener('track', async (event) => {
    remoteStream.addTrack(event.track, remoteStream);
});
///////////////////////////////////////////////////////
/*-------------------------------------------------Section 1------------------------------------------------------*/
async function generateAndStore(){
const offer=${offerSDP};

remoteConnection.onicecandidate = e =>  {
console.log(" NEW ice candidnat!! on localconnection reprinting SDP " )
 $("#answerSDP").append("<p style='color:purple;'>rewriting SDP from localConnection for each new Ice Canditate</p>");
 console.log(JSON.stringify(remoteConnection.localDescription) );
 $("#answerSDP").append(JSON.stringify(remoteConnection.localDescription));
storeAnswerSDP(JSON.stringify(remoteConnection.localDescription));
}

 


remoteConnection.setRemoteDescription(offer).then(a=>console.log("done"))

//create answer
remoteConnection.createAnswer().then(a => remoteConnection.setLocalDescription(a)).then(a=>
console.log(JSON.stringify(remoteConnection.localDescription)))
//send the anser to the client 
}

function storeAnswerSDP(answerSDP)	{
	$.post( "${pageContext.request.contextPath}/storeanswersdp", {answerSDP: answerSDP })
	  .done(function( data ) {
		  $("#storeAnswerSDPStatus").html(data);
		  $("#step1_3status").html("Step 1.3 has been completed successfy");
	  });
}	

function refreshAndGetOffer(){
		  $("#step1_2status").html("Step 1.2 has been completed successfy");
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
/*----------------------------------------------------------SECTION 2------------------------------------------------------*/
function sendMessage(){
	var message=document.getElementById("sendMessage").value;
	remoteConnection.channel.send(message);
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

function showAndSendMyMedia(){
	alert('hello');
}
</script>        
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    </body>
</html>