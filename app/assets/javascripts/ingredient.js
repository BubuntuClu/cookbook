$(document).ready(function(){
  $('body').on('click', '.js__delete_ingredient', 1, function(){
    if (confirm_deletion()){
      url = window.location.pathname.substr(0,window.location.pathname.length-4) + 'ingredients/' + $(this).attr('del_id');
      $.ajax({
        url: url,
        type: "delete",
        dataType: "json",
        success: function(data){
          $("#ingredient_" + data).remove()
        },
        error: function(data){
          console.log('не удалось удалить ингредиент: ' + data)
        }
      });
    }
  });

  function confirm_deletion(){
    return confirm("Вы уверены, что хотите удалить этот элемент?");
  };
});
