$(function () {

var intervalId = setInterval(function(){}, 10000);

function render_notification(data) {
    cont = $("<div></div>").addClass('ch-container');
    msg = $("<span></span>").addClass('notif');
    msg.text(data.ct);
    msg.appendTo(cont);
    cont.prependTo("#chat-container");
}

function render_chat(data) {
    cont = $("<div></div>").addClass('ch-container');
    icon = $("<div></div>").addClass('icon');
    icon.html('<img src="'+data.icon+'"/>');
    p = $("<div></div>").addClass('chat');
    p.text(data.ct);
    $('<h4></h4>').html(data.user).prependTo(p);
    icon.prependTo(p);
    p.prependTo(cont);
    cont.prependTo("#chat-container");
}

function process(data) {
    d = jQuery.parseJSON(data);
    if (d == null) return;
    var i = 0;
    for (i; i < d.length; i++) {
        if (d[i].content.context == "chat") {
            render_chat(d[i].content);
        }
        else {
            render_notification(d[i].content);
        }
    }
}

function ping() {
    clearInterval(intervalId);
    chan = $("#channel").val();
    $.get("/poll", function(data) {
            process(data);
            intervalId = setInterval(ping, 500);
        }
    );
}

$("body").ready( function() {
        $("#inputform").submit( function() {
                var url = "/talk"
                $.post(url, $("#inputform").serialize(), function(){
                    $("#cmdtext").removeAttr("disabled");
                    $("#cmdtext").val("");
                    });
                $("#cmdtext").attr("disabled", "disabled");
                return false;
            }
        );

        ping();
    }
);
});
