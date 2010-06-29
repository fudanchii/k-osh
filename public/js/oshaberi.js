$(function () {

var intervalId = setInterval(function(){}, 10000);

function render_notification(data) {
    cont = $("<li></li>");
    msg = $("<span></span>").addClass('notif');
    msg.text(data.ct);
    msg.appendTo(cont);
    cont.prependTo("#chat-container");
}

function render_chat(data) {
    cont = $("<li></li>")
    icon = $("<span></span>").addClass('icon');
    icon.html('<img src="'+data.icon+'">');
    icon.appendTo(cont);
    p = $("<span></span>").addClass('chat');
    p.text(data.ct);
    $("<h4></h4>").html(data.user).prependTo(p);
    p.appendTo(cont);
    cont.prependTo("#chat-container");
}

function process(data) {
    d = jQuery.parseJSON(data);
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
