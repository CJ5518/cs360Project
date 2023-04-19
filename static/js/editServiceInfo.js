$("#submitButton").click(function() {
	var str = "&NewService=true";
	if (ServiceID) {
		str = "&NewService=false&ServiceID=" + ServiceID;
	}
	console.log($('#editServiceInfoForm').serialize() + str);
	return;
	$.ajax({
		type : 'POST',
		url : '/services',
		data : $('#editServiceInfoForm').serialize() + str,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  }
	})
	window.location.href = "/";
})


$( "#serviceTypeSelect" ).change(function() {
	console.log($( "#serviceTypeSelect" ).val());
});