$(document).ready(function(){
  var votes = $('.votes');

  $('body').on('ajax:success', '.votes', 1,function(e, data, status, xhr){
    var result = $.parseJSON(xhr.responseText);
    $('#vote_' + result.id).html("<p>Рейтинг блюда: " + result.rating + "</p>");
    if (result.action == "vote"){
      $('#vote_' + result.id).parent().find('.vote_up').addClass('hidden')
      $('#vote_' + result.id).parent().find('.vote_down').addClass('hidden')
      $('#vote_' + result.id).parent().find('.unvote').removeClass('hidden')
    }
    if (result.action == "unvote"){
      $('#vote_' + result.id).parent().find('.vote_up').removeClass('hidden')
      $('#vote_' + result.id).parent().find('.vote_down').removeClass('hidden')
      $('#vote_' + result.id).parent().find('.unvote').addClass('hidden')
    }
  });
});
