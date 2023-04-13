$("#submitButton").click(function() {
	$.ajax({
		type : 'POST',
		url : '/homes',
		data : $('#editHomeInfoForm').serialize() + "&NewHome=true",
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  }
	})
	window.location.href = "/";
})