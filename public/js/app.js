$('#new').click(function() {
  ws = new WebSocket("ws://localhost:8080");

  ws.onmessage = function(evt) {
    var result = JSON.parse(evt.data);

    $('#player').text(result.player);
    $('#dice').text(result.dice);
    $('#points').text(result.points);
    $('#total_points').text(result.total_points);
    $('#remaining_dice').text(result.remaining_dice);
    $('#scoring_dice').text(result.scoring_dice);
  };

  $("#roll").click( function() {
    ws.send("roll");
  });
  $("#bank").click( function() {
    ws.send("bank");
  });
});


