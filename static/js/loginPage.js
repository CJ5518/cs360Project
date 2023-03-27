function requestPasswordReset() {
	$.ajax({
		url: "/passwordResetRequest",
		data: {
		  zipcode: 97201
		},
		success: function( result ) {
		  console.log("Success");
		}
	  });
}

function tryLogin() {
	console.log("Clickied");
	var request = $.ajax({
		method: "POST",
		url: "/loginAction",
		data: $("#loginForm").serialize(),
		statusCode: {
			401: function() {
				alert("Incorrect email or password");
			},
			200: function() {
				window.location.href = "/dashboard";
			}
		}
	  });
}