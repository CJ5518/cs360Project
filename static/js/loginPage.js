function requestPasswordReset() {
	$.ajax({
		url: "/passwordResetRequest",
		method: "POST",
		data: {
		  email: $("#email").val()
		},
		statusCode: {
			404: function(result) {
				alert("Could not find the email address you entered");
			},
			200: function(result) {
				alert(result.message);
			},
			500: function(res) {
				alert("Something went wrong on the server, sorry!");
			}
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