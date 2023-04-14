$("#logoutButton").click(function(){
	console.log("logoutButtonClick");
	$.ajax({
		method: "POST",
		url: "/logout"
}).done(function(){
	window.location.href = "/";
})
});