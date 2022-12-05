var DEMOS = [
    { id: "01", title: "Deploy Home Page", time: "??? mins", description: "Publish and Release an update the Kiosk Home Screen. Authorizing this release (automatically) for all corporate stores and manually accepted for the franchise store."},
    { id: "02", title: "Smart Update - Order Page", time: "???? mins", description: "Publish and Release an update to the Kiosk order screen, while a transaction is process the update will be blocked."},
    { id: "03", title: "Deploy and Rollback", time: "??? mins", description: "Publish and Release an update to all Kiosk pages, that release will also then be rolled back."},
    { id: "05", title: "Processor Deployment", time: "??? mins", description: "Demonstrate a non blocking install of a background service."},
    { id: "06", title: "Data Package Deployment", time: "??? mins", description: "Demonstrate Habitats ability to deploy data updates to stores. In this demo you will deploy a habitat package that updates the coupons available to a store."},
    
    { id: "07", title: "Store Configuration [Ring]", time: "??? mins", description: "Demonstrate the ability to use the Habitat Ring to share information accross devices. In this demo you will update details specific to a store and demonstrate how it propogates to the other devices in the same store."},

    { id: "07", title: "Compliance at the Edge", time: "??? mins", description: "TBD"},
    { id: "08", title: "Configuration at the Edge", time: "??? mins", description: "TBD"},
    { id: "09", title: "Automate and Edge Management", time: "??? mins", description: "TBD"},
    { id: "10", title: "[Technical] Supervisor Details", time: "??? mins", description: "TBD"},
    { id: "11", title: "[Technical] Visibility of the Edge", time: "??? mins", description: "TBD"}
];

var SERVICES = [
    { id: "00", title: "kiosk_proxy", description: "Deploys an NGINX proxy that has URL re-write rules to allow all of the services to expose APIs on port 80.", language: "COTS/Configuration only", tags: ["core/NGINX"]},
    { id: "01", title: "kiosk_ui", description: "The self ordering Kiosk UI / customer experience", language: "ASP DotNet Core", tags: ["core/dotnet-core","core/dotnet-asp-core", "core/dotnet-core-sdk"]},
    { id: "02", title: "kiosk_cart", description: "A service that maintains the current order transaction", language: "Go", tags: ["core/go"]},
    { id: "03", title: "kiosk_processor", description: "A service to simulate post order processing activities such as processing payment, or sending the order to a kitchen/back office system for processing.", language: "Go", tags: ["core/go"]},
    { id: "04", title: "kiosk_store", description: "A service used to maintain store specific configuration data such as StoreID, Tax Rate, Discount Codes, and the active inventory catalog", language: "Go", tags: ["core/go"]},
    { id: "05", title: "kiosk_inventory", description: "A service used to return the currently available order catalog along with pricing and images", language: "Go", tags: ["core/go"]},
    { id: "06", title: "kiosk_meta", description: "A service used to expose metadata of all running services and of the stores device", language: "Go", tags: ["core/go"]},
    { id: "07", title: "kiosk_coupons", description: "A data package used to update the coupons.", language: "Bash scripts", tags: ["core/bash", "core/curl"]},
    { id: "08", title: "kiosk_hostCompliance", description: "InSpec compliance profiles running to verify the device (host) compliance/configuration.", language: "InSpec - Profile", tags: ["chef/inspec"]},
    { id: "09", title: "kiosk_appCompliance", description: "InSpec compliance profiles running to verify app compliance.", language: "InSpec - Profile", tags: ["chef/inspec"]},
    { id: "10", title: "kiosk_hostConfig", description: "Chef cookbooks running to enfore continous desired state configuration of the host", language: "Chef - Cookbook", tags: ["chef/chef"]},
    { id: "11", title: "kiosk_discover", description: "Chef ohai collecting detailed node information on each device", language: "Chef - Ruby", tags: ["core/ruby"]},
];

(function ($) {    
    if( $("#demoTemplate").length > 0 ){
        var demoTemplate = $.templates("#demoTemplate"); 
        var demoHtml = demoTemplate.render({ items: DEMOS }); 
        $("#demoRow").html(demoHtml);         

        var serviceTemplate = $.templates("#serviceTemplate"); 
        var serviceHtml = serviceTemplate.render({ items: SERVICES }); 
        $("#serviceRow").html(serviceHtml);         

        $(".testimonial__slider").owlCarousel({
            loop: true,
            margin: 0,
            items: 1,
            dots: true,
            smartSpeed: 2000,
            autoHeight: false,
            autoplay: true,
            autoplayTimeout: 15000,
            mouseDrag: true,
            touchDrag: false,
            pullDrag: true,
            autoplayHoverPause: true
        });        
    }
})(jQuery);
