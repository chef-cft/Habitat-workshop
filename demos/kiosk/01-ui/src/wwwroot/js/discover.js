(function ($) {    
    
    if( $("#node-ohai-json").length > 0){
        $.get(_DiscoverApiEndPoint, function(data) {
            $("#node-ohai-json").html("");
            jsonView.format(JSON.stringify(data), '#node-ohai-json');
        });       
    }
    
})(jQuery);
