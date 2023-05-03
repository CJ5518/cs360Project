$("#submitButton").click(function() {
	if (false) {
		var str = "&NewService=false&ServiceID=" + ServiceID;
	}
	
	//If the form is valid
	if ($('#serviceSearchForm')[0].reportValidity()) {
		console.log($('#serviceSearchForm').serialize());
		$.ajax({
			type : 'GET',
			url : '/serviceSearchAction',
			data : $('#serviceSearchForm').serialize(),
			error: function(xhr, status, error) {
				console.log(xhr.responseText);
			  }
		})
		
	}
})

var theActiveSection = null;
var theOldID = null;

function onServiceTypeChange() {


	if (theActiveSection == null) {
		theActiveSection = $("#serviceFieldDiv" + $( "#serviceTypeSelect" ).val());
	} else {
		//Do the big ones
		theActiveSection.attr("style", "display: none;");
		theActiveSection.children().each(function() {
			$(this).attr("disabled", true);
		})

		//Now the little comparison guys
		$("#serviceFieldDiv" + theOldID + " .fieldCompParent div select").each(function(){
			$(this).attr("disabled", true);
			$(this).attr("style", "display: none;");
		});
	}
	
	theOldID = $( "#serviceTypeSelect" ).val();
	theActiveSection = $("#serviceFieldDiv" + $( "#serviceTypeSelect" ).val());

	theActiveSection.attr("style", "display: inline;");
	theActiveSection.children().each(function() {
		$(this).attr("disabled", false);
	})

	$("#serviceFieldDiv" + $( "#serviceTypeSelect" ).val() + " .fieldCompParent div select").each(function(){
		$(this).attr("disabled", false);
		$(this).attr("style", "display: inline;");
	});
}

$( "#serviceTypeSelect" ).change(function() {
	onServiceTypeChange();
});

$( document ).ready(function(){
	onServiceTypeChange();
})