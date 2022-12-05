(function ($) {

    if ($("#inventory-loading").length > 0) {
        $.get( _InventoryApiEndPoint, function(data) {
                loadStore(_InventoryImages, data);
            }).fail(function() {
                alert( "error" );
            });
    }

    if ($("#review-order-page").length > 0) {
        $.get( _CartApiEndPoint, function(data) {
                loadOrder(data);
            }).fail(function() {
                alert( "error" );
            });
    }   

    $("#clear-cart").click(function (e) {
        cancelOrder();
    });

    $("#formApplyDiscount").submit(function (e) {
        e.preventDefault();

        $.ajax({
            url:  _CartApiEndPoint + "/coupon",
            data: { code: $("#txtCouponCode").val() },
            cache: false,
            type: "GET",
            success: function(data) {
                loadOrder(data);
                $("#txtCouponCode").val("");
            },
            error: function(xhr) {
                alert( "error applying coupon" );
            }
        });
    });

    $("#btnCheckOut").click(function (e) {
        e.preventDefault();

        $.get( _ProcessorApiEndPoint + "/start", function(data) {
            window.location.href = "Processor"
        }).fail(function() {
            alert( "error" );
        });
    });

    
    

})(jQuery);

var _INVENTORY = null;

function cancelOrder(){
    $.get( _CartApiEndPoint + "/clear", function(data) {
        updateCart(data);
        window.location.href = "/";
    }).fail(function() {
        alert( "error" );
    });
}

function loadStore(img, payload){
    _INVENTORY = payload;

    var filterTemplate = $.templates("#filterTemplate"); 
    var itemTemplate = $.templates("#itemTemplate"); 
    
    var filterArray = [];

    payload.forEach( function(src){
        src.category.split(" ").forEach( function(item){        
            if(!filterArray.includes(item)){
                filterArray.push(item);
            }
        });
    });


    var filterData = { items: [] };
    filterArray.forEach( function(item){
        var filter = { tag: item, name: ""}
        filter.name += item.charAt(0).toUpperCase();
        filter.name += item.slice(1);
        filterData.items.push(filter);
    });

    var filterHtml = filterTemplate.render(filterData); 
    $("#filterMenu").html(filterHtml);           

    var itemData = { path: img, items: payload };

    var itemTemplate = itemTemplate.render(itemData);      
    $("#itemCatalog").html(itemTemplate);                  
    $('#inventory-loading').hide()
    $('#inventory').show();
    
    setupIsotopeFilters();
    setupCart();
}

function setupIsotopeFilters(){
    $('.filters_menu li').click(function () {
        $('.filters_menu li').removeClass('active');
        $(this).addClass('active');

        var data = $(this).attr('data-filter');
        $grid.isotope({
            filter: data
        })
    });

    var $grid = $(".grid").isotope({
        itemSelector: ".all",
        percentPosition: false,
        masonry: {
            columnWidth: ".all"
        }
    })
}

function setupCart(){

    $.get( _CartApiEndPoint + "/", function(data) {
        updateCart(data);
    }).fail(function() {
        alert( "error" );
    });

    $("#review-order").click(function (e) {
        e.preventDefault();
        window.location.href = "/Review";
    });

    $(".addToCart").click(function (e) {
        e.preventDefault();

        var product = null;
        var id = $(this).attr('productId');

        _INVENTORY.forEach( function(item){
            if(item.id == id){
                product = item;
            }
        });

        $.ajax({
            type: "POST",
            url: _CartApiEndPoint + "/add",
            data: JSON.stringify(product),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data){
                updateCart(data);
            },
            error: function(errMsg) {
                alert(errMsg);
            }
        });      
        
    });
}

function updateCart(data){
    if(data == null || data === undefined || (data.lines && data.lines.length == 0))
    {
        $('#cart-panel').hide();
        $("#transaction-indicator").hide();
        var tpl = $.templates("#emptyCartTemplate"); 
        var itemHtml = tpl.render(data);      
        $("#cart-details").html(itemHtml);
    }else{
        if( data.lines == null || data.lines.length == 0 ){
            $('#cart-panel').hide();
            $("#transaction-indicator").hide();
        } else {
            $("#transaction-indicator").show();
            $('#cart-panel').show();
            var tpl = $.templates("#cartTemplate"); 
            var itemHtml = tpl.render(data);      
            $("#cart-details").html(itemHtml);         
        }
    }
}

//REVIEW PAGES


function loadOrder(payload){
    updateOrderDetails(payload);
}

function updateOrderDetails(data){
    var tpl = $.templates("#cartReviewTemplate"); 
    var itemHtml = tpl.render(data);      
    $("#order-details").html(itemHtml);   

    var tpl = $.templates("#cartTotalTemplate"); 
    var itemHtml = tpl.render(data);      
    $("#order-total").html(itemHtml);      

    $(".removeFromCart").click(function(e){
        e.preventDefault();
        var id = $(this).attr('productId');
        $.get( _CartApiEndPoint + "/remove?id=" + id, function(data) {
            if(data.lines == null || data.lines.length == 0){
                cancelOrder();
            }else{
                updateOrderDetails(data);
            }
        }).fail(function() {
            alert( "error" );
        });
    });

}

