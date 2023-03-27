$("#logoutButton").click(function(){
	console.log("HERE");
	$.ajax({
		method: "POST",
		url: "/logout"
}).done(function(){
	window.location.href = "/";
})
});