(function ($) {
    var RING_DATA = undefined;

    if( $("#ddServiceGroups").length > 0 && $("#ddServiceGroupMembers").length > 0  ){    
        $.get(_MetaApiEndPoint+ "/ring", function(data) {
            RING_DATA = data;

            $.map(RING_DATA.censusGroups, function(obj, item){
                $('#ddServiceGroups').append($('<option>', { 
                    value: item,
                    text : item 
                }));
              });

            $("#ddServiceGroups").change(function() {
                loadServiceGroups(RING_DATA);
            });
        
            $("#ddServiceGroupMembers").change(function() {
                loadServiceGroupMembers(RING_DATA);
            });

            loadServiceGroups(RING_DATA);
            loadServiceGroupMembers(RING_DATA);
        });                
        return;
    }
})(jQuery);


function loadServiceGroups(RING_DATA){
    var key = $("#ddServiceGroups").val();
    var pop = RING_DATA.censusGroups[key].population;
    var me = RING_DATA.censusGroups[key].self; //memberId
    var cfg = RING_DATA.censusGroups[key].serviceConfig

    $('#self-name-val').html(key);
    $('#self-memberId-val').html(me.memberId);

    $('#ddServiceGroupMembers').find('option').remove().end();
    $.map(pop, function(obj, item){
        $('#ddServiceGroupMembers').append($('<option>', { 
            value: item,
            text : item 
        }));
    });

    $('#ring-self-data').html("");
    jsonView.format(JSON.stringify(me), '#ring-self-data');

    $('#ring-data-cfg').html("");
    jsonView.format(JSON.stringify(cfg), '#ring-data-cfg');
}

function loadServiceGroupMembers(RING_DATA){
    var svc = $("#ddServiceGroups").val();
    var key = $("#ddServiceGroupMembers").val();

    var pop = RING_DATA.censusGroups[svc].population[key];

    $('#target-memberId-val').html(pop.memberId);
    $('#ring-member-data').html("");
    jsonView.format(JSON.stringify(pop), '#ring-member-data');

}
