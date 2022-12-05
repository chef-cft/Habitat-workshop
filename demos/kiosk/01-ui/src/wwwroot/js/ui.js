const STATUS_ONLINE = 1;
const STATUS_WAITING = 2;
const STATUS_OFFLINE = 3;
const STATUS_TIME = 2 * 1000;
const VERSION_TIME = 10.7 * 1000;
const STORE_TIME = 9.3 * 1000;
const TRANS_TIME = 5 * 1000;
var RELOADING = false;

var UI_SERVICES = [
    { id: "svc-proxy-ver",      key: "proxy",           title: "Proxy Service",                 message: "Proxy service updated",           reload: false   },
    { id: "svc-inv-ver",        key: "inventory",       title: "Inventory Service",             message: "Inventory service updated",       reload: false   },
    { id: "svc-ui-ver",         key: "ui",              title: "UI Service",                    message: "UI service updated",              reload: false   },
    { id: "svc-cart-ver",       key: "cart",            title: "Cart Service",                  message: "Cart service updated",            reload: false   },
    { id: "svc-processor-ver",  key: "processor",       title: "Processor Service",             message: "Processor service updated",       reload: false   },
    { id: "svc-store-ver",      key: "store",           title: "Store Service",                 message: "Store service updated",           reload: false   },
    { id: "svc-meta-ver",       key: "meta",            title: "Metadata Service",              message: "Metadata service updated",        reload: false   },
    { id: "svc-coupon-ver",     key: "coupons",         title: "Coupon Data",                   message: "Coupon Data updated",             reload: false   },
    { id: "svc-host-ver",       key: "hostCompliance",  title: "Host Compliance Profile",       message: "InSpec (Host) profile updated",   reload: false   },
    { id: "svc-app-ver",        key: "appCompliance",   title: "App Compliance Profile",        message: "InSpec (App) profile updated",    reload: false   },
    { id: "svc-config-ver",     key: "config",          title: "Host Configuration Cookbook",   message: "Chef Cookbook updated",           reload: false   },
    { id: "svc-discover-ver",   key: "discover",        title: "Discovery Service",             message: "Discover service updated",        reload: true    }
];

(function ($) {    
    var lastStatus = STATUS_ONLINE;
    var lastVersion = undefined;

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-full-width",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "10000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }    

    function queryStore() {
        $.get(_StoreApiEndPoint, function(data) {
            updateStoreValues(data);
            if(POLL_STORE_ENABLE){ setTimeout(queryStatus, STORE_TIME); }
        }).fail(function() {
            updateStoreValues(undefined);
            if(POLL_STORE_ENABLE){ setTimeout(queryStatus, STORE_TIME); }
        });        

    }

    function queryStatus() {
        
        $.get("/api/health", function(data) {
            if(data == "online") {
                lastStatus = updateStatusUI(STATUS_ONLINE, lastStatus);
            }else if(data == "waiting") {
                lastStatus = updateStatusUI(STATUS_WAITING, lastStatus);                
            }
            if(POLL_STATUS_ENABLE){  setTimeout(queryStatus, STATUS_TIME); }
        }).fail(function() {
            lastStatus = updateStatusUI(STATUS_OFFLINE, lastStatus);
            if(POLL_STATUS_ENABLE){  setTimeout(queryStatus, STATUS_TIME); }
        });        
    }

    function queryVersion() {        
        $.get( _MetaApiEndPoint + "/versions", function(data) {
            lastVersion = updateVersionUI(data, lastVersion);
            if(POLL_VERSION_ENABLE){ setTimeout(queryVersion, VERSION_TIME); }
        }).fail(function() {            
            lastVersion = updateVersionUI(undefined, lastVersion);
            if(POLL_VERSION_ENABLE){ setTimeout(queryVersion, VERSION_TIME); }
        });        
    }


    function queryTransaction() {        
        $.get( _CartApiEndPoint + "/exists", function(data) {            
            $("#transaction-indicator").show();
            if(POLL_TRANS_ENABLE){ setTimeout(queryTransaction, TRANS_TIME); }
        }).fail(function() {            
            $("#transaction-indicator").hide();
            if(POLL_TRANS_ENABLE){ setTimeout(queryTransaction, TRANS_TIME); }
        });        
    }

    setTimeout(queryStatus);
    setTimeout(queryVersion);
    setTimeout(queryStore);
    setTimeout(queryTransaction);

})(jQuery);

function updateStoreValues(data){
    $("#store-id-val").html(data !== undefined && data.storeId ? data.storeId : "offline");
    $("#store-catalog-val").html(data !== undefined && data.catalog ? data.catalog : "offline");
    $("#store-tax-val").html(data !== undefined && data.taxRate ? data.taxRate : "offline");
    $("#store-disc-val").html(data !== undefined && data.discount ? "enabled" : "disabled");
}

function updateStatusUI(current, prior){
    if(prior == current){
        return current;
    }

    if( current == STATUS_WAITING ){
        notice("warning", "Update Pending", "Please finish your transaction an update is pending.");
    }

    if( current == STATUS_OFFLINE ){
        notice("error", "Offline", "UI is offline please wait");
    }

    if( current == STATUS_ONLINE && prior == STATUS_OFFLINE){
        RELOADING = true;
        notice("info", "UI Updated", "UI Will Refresh in 5 seconds");
        setTimeout(function(){ window.location.reload()}, 5 * 1000);
    }
    return current;
}

function updateVersionUI(current, prior){       
    if(current !== undefined && prior !== undefined){
        $.map(UI_SERVICES, function(item){

            if( current[item.key] && !prior[item.key]){
                message = item.title + " is online <br/> " + 
                    "version <br/>" + 
                    current.ui.version + " <small>(" + current.ui.build + ")</small>";                    
                notice("success", item.title, message);
            } else if( current[item.key] && current[item.key].id > prior[item.key].id){

                message = item.message + " from <br/> " + 
                    prior.ui.version + " <small>(" + prior.ui.build + ")</small>" + 
                    "<br/>to<br/>" + 
                    current.ui.version + " <small>(" + current.ui.build + ")</small>";

                notice("success", item.title, message);
                if(item.reload && !RELOADING){
                    notice("info", "UI Updated", "UI Will Refresh in 5 seconds");
                    setTimeout(function(){ window.location.reload()}, 5 * 1000); 
                }           
            }             
        });
    }
    
    if (current === undefined) {
        current = prior;
    }
    
    /*
    $("#svc-proxy-ver").html(current.proxy ? current.proxy.version : "offline");
    $("#svc-inv-ver").html(current.inventory ? current.inventory.version : "offline");
    $("#svc-ui-ver").html(current.ui ? current.ui.version : "offline");
    $("#svc-cart-ver").html(current.cart ? current.cart.version : "offline");
    $("#svc-processor-ver").html(current.processor ? current.processor.version : "offline");
    $("#svc-store-ver").html(current.store ? current.store.version : "offline");
    $("#svc-meta-ver").html(current.meta ? current.meta.version : "offline");

    $("#svc-coupon-ver").html(current.coupon ? current.coupon.version : "offline");
    $("#svc-host-ver").html(current.hostCompliance ? current.hostCompliance.version : "offline");
    $("#svc-app-ver").html(current.appCompliance ? current.appCompliance.version : "offline");
    $("#svc-config-ver").html(current.config ? current.config.version : "offline");
    $("#").html(current.discover ? current.discover.version : "offline");
*/

    $.map(UI_SERVICES, function(item){
        $("#"+item.id).html(current[item.key] ? current[item.key].version : "offline");
    });

    return current;
}


function notice(type, message, title){        
    toastr[type](title, message);
    console.log(type, title, message);
}
