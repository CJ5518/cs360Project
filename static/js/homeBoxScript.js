//Include this script in any page that uses home boxes
//Which I think is just the user dashboard


function homeBoxDeleteButtonFunc(id) {
	$.ajax({
		type : 'DELETE',
		url : '/homes',
		data : "HomeID=" + id,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  }
	})
	location.reload() 
}

function homeBoxEditButtonFunc(id) {
	window.location.href = "/editHomeInfo?HomeID=" + id;
}