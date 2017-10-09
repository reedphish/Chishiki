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
              var table = $("#sresult").DataTable();
              table.clear();

              $.each(response["query"]["hits"]["hits"], function(key, data) {
                 table.row.add([
                   data["_source"]["release"],
                   data["_source"]["osname"]
                 ]);
              });

              table.draw(false);
  					}
    			});
    		}
    	});
        return this;
    };
}(jQuery));
