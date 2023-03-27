function requestPasswordReset() {
	$.ajax({
		url: "/passwordResetRequest",
		data: {
		  zipcode: 97201
		},
		success: function( result ) {
		  console.log("Success");
		},
		fail
	  });
}

function tryLogin() {
	
}