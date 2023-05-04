var selectedHome = $('#homeSelect').find(":selected").val();

function onRequestButtonClicked(userID, serviceID) {
	$.ajax({
		type : 'POST',
		url : '/order',
		data : "HomeID=" + $('#homeSelect').find(":selected").val() + "&UserID=" + userID + "&ServiceID=" + serviceID,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  },
		success: function(res) {
			console.log(res);
			alert("Your order has been placed");
			window.location.href = "/";
		}
	})
}