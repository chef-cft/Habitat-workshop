(function ($) {
    const STATUS_RELOAD_TIME = 1 * 1000;
    
    $("#ddCompliance-Type").change(function() {
        loadComplianceType();
    });
    
    $("#ddCompliance-Report-Type").change(function() {
        loadComplianceReport();
    });
    
    $("#btnToggleCompliance").click(function(e) {
        e.preventDefault();
        var url = eval($("#ddCompliance-Type").val());        

        $.get(url + "toggle", function(status) {
            $("#compliance-engine").html(status.command);
            $("#compliance-duration").html(status.duration);
            $("#compliance-status").html(status.active ? "Active" : "Paused");
            $("#compliance-last-run").html(status.lastRun);
            $("#compliance-next-run").html(status.nextRun);
        });        
    });

    $("btnManualRunCompliance").click(function(e) {
        e.preventDefault();
        $.get(url + "run", function(status) {
            $("#compliance-engine").html(status.command);
            $("#compliance-duration").html(status.duration);
            $("#compliance-status").html(status.active ? "Active" : "Paused");
            $("#compliance-last-run").html(status.lastRun);
            $("#compliance-next-run").html(status.nextRun);            
        });        
    });

    function loadComplianceStatus(){
        var url = eval($("#ddCompliance-Type").val());        
        $.get(url, function(status) {
            $("#compliance-engine").html(status.command);
            $("#compliance-duration").html(status.duration);
            $("#compliance-status").html(status.active ? "Active" : "Paused");
            $("#compliance-last-run").html(status.lastRun);
            $("#compliance-next-run").html(status.nextRun);
            setTimeout(loadComplianceStatus, STATUS_RELOAD_TIME);
        });        
    }

    function loadComplianceType(){
        var url = eval($("#ddCompliance-Type").val());        
        $.get(url+ "/report", function(files) {
            $('#ddCompliance-Report-Type').find('option').remove().end();

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
                $('#ddCompliance-Report-Type').append($('<option>', { 
                    value: item,
                    text : item 
                }));
            });

            loadComplianceReport();
        });
    }

    function loadComplianceReport(){
        var url = eval($("#ddCompliance-Type").val());        
        var rpt = $("#ddCompliance-Report-Type").val();  
        var target = url+ "/report?report="+rpt;
        $("#compliance-report").html("");
        $('<iframe src="'+target+'" style="width:100%; height: 400px" id="content-frame"/>').appendTo('#compliance-report');
    }

    if ( $("#ddCompliance-Type").length > 0 ){
        loadComplianceType();
        setTimeout(loadComplianceStatus, STATUS_RELOAD_TIME);
    }
})(jQuery);