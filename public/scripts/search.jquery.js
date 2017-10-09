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
              var resultspane = $("#searchresults");
              resultspane.empty();

              $.each(response["query"]["hits"]["hits"], function(key, data) {
                var div = $("<div>")
                div.addClass("searchresult");
                div.addClass("greenleftborder")
                div.append($("<h1>").text(data["_source"]["release"]));
                div.append($("<h2>").text(data["_source"]["osname"] ));
                resultspane.append(div);
                console.log(data);
              });
  					}
    			});
    		}
    	});
        return this;
    };
}(jQuery));
