//Include this script in any page that uses service boxes
//Which a lot of them


function serviceBoxDeleteButtonFunc(id) {
	$.ajax({
		type : 'DELETE',
		url : '/services',
		data : "ServiceID=" + id,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  }
	})
	location.reload() 
}

function serviceBoxEditButtonFunc(id) {
	window.location.href = "/editServiceInfo?ServiceID=" + id;
}