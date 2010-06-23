$(function () {
function ping() {
    $.get("/poll",function(data){
            $("#chatlog").prepend(data);
        }
    );
    setTimeout(ping,1000.0);
}

$("body").ready( function() {
        $("#inputform").submit( function() {
                var url = "/talkto/" + $("#channel").val();
                $.post(url, $("#inputform").serialize());
                $("#cmdtext").val("");
                return false;
            }
        );
        ping();
    }
);
});
