$('#new').click(function() {
  ws = new WebSocket("ws://localhost:8080");

  ws.onmessage = function(evt) {
    var result = JSON.parse(evt.data);

    if(result.hasOwnProperty('dice')){
      $('.checkbox_container').remove();

      for(var die in result.dice[0]){
        $('#taglist').append(
          '<div class="checkbox_container">'+
            '<input type="checkbox" class="checkbox" value="'+result.dice[0][die]+'">'+result.dice[0][die]+
          '</div>'
          );
      }

      $('#player').text(result.player);
      $('#non_scoring_dice').text(result.dice[1]);
      $('#round_points').text(result.round_points);
      $('#total_points').text(result.total_points);
      $('#roll_points').text(result.roll_points);
    };
    if (result.hasOwnProperty('roll_points')) {
      $('#roll_points').text(result.roll_points);
    };
  };

  $("#roll").click(function() {
    ws.send('{ "msg": "roll" }');
  });
  $("#bank").click(function() {
    ws.send('{ "msg": "bank" }');
  });

  $(document).on('change', 'input', function() {
    var values = $("input:checkbox:checked").map(function(){
      return $(this).val();
    }).get(); 
    ws.send('{ "get_points": ['+values+']}');
    console.log(values);
  });
});



