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

function cancelButtonClick(orderID) {
	$.ajax({
		type : 'DELETE',
		url : '/order',
		data : "OrderID=" + orderID,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  },
		success: function(res) {
			alert("Your order has been canceled");
			window.location.href = "/";
		}
	})
}
function acceptButtonClick(orderID) {
	$.ajax({
		type : 'POST',
		url : '/acceptOrder',
		data : "OrderID=" + orderID,
		error: function(xhr, status, error) {
			console.log(xhr.responseText);
		  },
		success: function(res) {
			alert("The order has been accepted");
			window.location.href = "/";
		}
	})
}

