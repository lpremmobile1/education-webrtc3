<%-------------------------------------------------STEP 1.4-------------------------------------------------------%>
<br>	
<p>Answer SDP from <span class="badge bg-dark">Peer B</span> will be shown below </p>
<div id="offerSDP" style="background-color: rgb(245, 245, 245); width: 70vw;height: 150px; overflow: scroll;">${answerSDP}</div> <br>
<h5 style="background-color: rgb(245, 245, 245); text-align:center; color: green;" id="Step1_4status">Step 1.4 completed successfully.</h5>
<%-------------------------------------------------STEP 1.5-------------------------------------------------------%>
<hr style="height: 8px;background: fuchsia;">
<button class="btn btn-danger" onclick="openConnection()">Open Connection Now &nbsp;&nbsp;<span class="badge bg-secondary">Step 1.5</span></button>
<h5 style="background-color: rgb(245, 245, 245); text-align:center; color: green;" id="Step1_5status"></h5>
<script>
function openConnection(){
	//this opens the connection
	const answer = ${answerSDP};
	localConnection.setRemoteDescription (answer).then(a=>{console.log("done");$("#Step1_5status").html("Step1.5 has been completed successfully.");$("#connectionStatus").html("Connected");});
}
</script>