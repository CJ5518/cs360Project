$("#submitButton").click(function() {
	var str = "&NewHome=true";
	if (HomeID) {
		str = "&NewHome=false&HomeID=" + HomeID;
	}
	$.ajax({
		type : 'POST',
		url : '/homes',
		data : $('#editHomeInfoForm').serialize() + str,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  }
	})
	window.location.href = "/";
})