(function ($) {
    var SERVICE_DATA = undefined;

    $("#node-svc-details").change(function() {
        loadNodeDetails();
    });

    $("#habitat-svc-details").change(function() {
        loadServiceDetails();
    });

    function loadNodeDetails(){
        var path = $("#node-svc-details").val();
        $("#node-svc-title").html( $("#node-svc-details option:selected").text() );
        $.get(_MetaApiEndPoint + path, function(data) {
            $("#node-svc-json").html("");
            jsonView.format(JSON.stringify(data), '#node-svc-json');
        });        
    }

    function loadServiceDetails(){
        if(SERVICE_DATA === undefined){
            $.get(_MetaApiEndPoint+ "/services", function(data) {
                SERVICE_DATA = data;
                loadServiceDetails();
            });        
            return;
        }
        var id = $("#habitat-svc-details").val();
        $("#habitat-svc-title").html( $("#habitat-svc-details option:selected").text() );
        $("#habitat-svc-json").html("");
        SERVICE_DATA.forEach( function(item){
            if(item.spec_ident &&  item.spec_ident.name == id ){
                jsonView.format(JSON.stringify(item), '#habitat-svc-json');
            }
        });
    }
    
    if( $("#node-svc-details").length > 0 ){
        loadNodeDetails();
    }

    if( $("#habitat-svc-details").length > 0 ){
        loadServiceDetails();
    }
})(jQuery);
