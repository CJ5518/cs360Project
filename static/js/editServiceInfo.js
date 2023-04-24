$("#submitButton").click(function() {
	var str = "&NewService=true";
	if (ServiceID) {
		str = "&NewService=false&ServiceID=" + ServiceID;
	}
	
	//If the form is valid
	if ($('#editServiceInfoForm')[0].reportValidity()) {
		$.ajax({
			type : 'POST',
			url : '/services',
			data : $('#editServiceInfoForm').serialize() + str,
			error: function(xhr, status, error) {
				console.log(xhr.responseText);
			  }
		})
		console.log($('#editServiceInfoForm').serialize() + str);
		window.location.href = "/";
	}
})

var theActiveSection = null;

function onServiceTypeChange() {
	console.log($( "#serviceTypeSelect" ).val());

	if (theActiveSection == null) {
		theActiveSection = $("#serviceFieldDiv" + $( "#serviceTypeSelect" ).val());
	} else {
		theActiveSection.attr("style", "display: none;");
		theActiveSection.children().each(function() {
			$(this).attr("disabled", true);
		})
	}
	
	
	theActiveSection = $("#serviceFieldDiv" + $( "#serviceTypeSelect" ).val());
	theActiveSection.attr("style", "display: inline;");
	theActiveSection.children().each(function() {
		$(this).attr("disabled", false);
	})
}

$( "#serviceTypeSelect" ).change(function() {
	onServiceTypeChange();
});

$( document ).ready(function(){
	onServiceTypeChange();
})