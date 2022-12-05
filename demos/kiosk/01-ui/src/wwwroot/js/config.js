(function ($) {
    const STATUS_RELOAD_TIME = 1 * 1000;
    
    $("#ddConfig-Type").change(function() {
        loadConfigType();
    });
    
    $("#ddConfig-Report-Type").change(function() {
        loadConfigReport();
    });
    
    $("#btnToggleConfig").click(function(e) {
        e.preventDefault();
        var url = eval($("#ddConfig-Type").val());        

        $.get(url + "toggle", function(status) {
            $("#config-engine").html(status.command);
            $("#config-duration").html(status.duration);
            $("#config-status").html(status.active ? "Active" : "Paused");
            $("#config-last-run").html(status.lastRun);
            $("#config-next-run").html(status.nextRun);
        });        
    });

    $("btnManualRunConfig").click(function(e) {
        e.preventDefault();
        $.get(url + "run", function(status) {
            $("#config-engine").html(status.command);
            $("#config-duration").html(status.duration);
            $("#config-status").html(status.active ? "Active" : "Paused");
            $("#config-last-run").html(status.lastRun);
            $("#config-next-run").html(status.nextRun);            
        });        
    });

    function loadConfigStatus(){
        var url = eval($("#ddConfig-Type").val());        
        $.get(url, function(status) {
            $("#config-engine").html(status.command);
            $("#config-duration").html(status.duration);
            $("#config-status").html(status.active ? "Active" : "Paused");
            $("#config-last-run").html(status.lastRun);
            $("#config-next-run").html(status.nextRun);
            setTimeout(loadConfigStatus, STATUS_RELOAD_TIME);
        });        
    }

    function loadConfigType(){
        var url = eval($("#ddConfig-Type").val());        
        $.get(url+ "/report", function(files) {
            $('#ddConfig-Report-Type').find('option').remove().end();

            files.sort(function(s1,s2){
                s1Dot = s1.lastIndexOf('.');
                s2Dot = s2.lastIndexOf('.');
                if ((s1Dot == -1) == (s2Dot == -1)) { // both or neither
                    s1 = s1.substring(s1Dot + 1);
                    s2 = s2.substring(s2Dot + 1);
                    if ( s1 < s2){ return -1;}
                    if ( s1 > s2){ return 1;}
                    return 0;
                } else if (s1Dot == -1) { // only s2 has an extension, so s1 goes first
                    return -1;
                } else { // only s1 has an extension, so s1 goes second
                    return 1;
                }
            });

            $.map(files, function(item, idx){
                $('#ddConfig-Report-Type').append($('<option>', { 
                    value: item,
                    text : item 
                }));
            });

            loadConfigReport();
        });
    }

    function loadConfigReport(){
        var url = eval($("#ddConfig-Type").val());        
        var rpt = $("#ddConfig-Report-Type").val();  
        var target = url+ "/report?report="+rpt;
        $("#config-report").html("");
        $('<iframe src="'+target+'" style="width:100%; height: 400px" id="content-frame"/>').appendTo('#config-report');
    }

    if ( $("#ddConfig-Type").length > 0 ){
        loadConfigType();
        setTimeout(loadConfigStatus, STATUS_RELOAD_TIME);
    }
})(jQuery);