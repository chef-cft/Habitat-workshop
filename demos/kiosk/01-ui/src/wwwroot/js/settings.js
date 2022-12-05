(function ($) {

    const STORE_CONFIG_TIME = 2 * 1000;
    var FIRST = true;
    var LAST = {}

    function queryStoreConfig() {
        $.get(_StoreApiEndPoint, function(data) {

            $("#store-id-cfg").html(data.storeId);
            $("#store-catalog-cfg").html(data.catalog);
            $("#store-tax-cfg").html(data.taxRate);
            $("#store-disc-cfg").html(data.discount ? "enabled" : "disabled");

            $("#store-id-val").html(data.storeId);
            $("#store-catalog-val").html(data.catalog);
            $("#store-tax-val").html(data.taxRate);
            $("#store-disc-val").html(data.discount ? "enabled" : "disabled");

            if(JSON.stringify(LAST) !== JSON.stringify(data)){
                FIRST = true;
                LAST = data;
            }

            if(FIRST && data !== undefined){
                FIRST = false;
                $("#txtStoreID").val(data.storeId);
                $("#ddCatalog").val(data.catalog);
                $("#txtTaxRate").val(data.taxRate);
                $("#ddDiscounts").val(data.discount ? "true" : "false");
                $("#updateSettingsForm :input").prop("disabled", false);
                $("#updateSettingsForm .site-btn").show();
            }

            var couponTemplate = $.templates("#couponTemplate"); 
            var couponHtml = couponTemplate.render(data); 
            $("#couponList").html(couponHtml);         
            setTimeout(queryStoreConfig, STORE_CONFIG_TIME);
        }).fail(function() {
            setTimeout(queryStoreConfig, STORE_CONFIG_TIME);
        });        
    }

    if( $("#updateSettingsForm").length > 0){
        setTimeout(queryStoreConfig);

        $( "#updateSettingsForm" ).submit(function( event ) {
            event.preventDefault();
            updateSettings();
        });        
    }

    function updateSettings(){
        var payload = {};
        payload.storeId = parseInt( $("#txtStoreID").val() );
        payload.catalog = $("#ddCatalog :selected").val();
        payload.taxRate = parseFloat( $("#txtTaxRate").val() );
        payload.discount = $("#ddDiscounts :selected").val() == "true";

        $("#updateSettingsForm :input").prop("disabled", true);
        $("#updateSettingsForm .site-btn").hide();

        $.ajax({
            type: "POST",
            url: _StoreApiEndPoint,
            data: JSON.stringify(payload),
            contentType: "application/json; charset=utf-8",
            success: function(data, status) {
                console.log(data);                
            },
            error: function(data){
                alert("error sending store config data");
            }//,
            //dataType: dataType
          });
    }

})(jQuery);
