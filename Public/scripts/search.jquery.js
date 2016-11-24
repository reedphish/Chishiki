(function ($) {
    $.fn.searchbar = function() {
    	var searchbar = this;

    	this.on("keypress", function(event) {
    		var keycode = event.keyCode ? event.keyCode : event.which;

    		if(keycode == 13) {
    			$.ajax({
    				method: "POST",
 					url: "rest/search",
  					data: { query: searchbar.val() },
  					dataType: "json",
  					success: function(response) {
  						console.log(response);
  					}
    			});
    		}
    	});
        return this;
    };
}(jQuery));