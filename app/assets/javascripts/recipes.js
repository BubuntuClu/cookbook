$(document).ready(function(){
  if ($('.pagination').length){
    $(window).scroll(function(){
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() + window.innerHeight > $(document).height() - 50) {
        $('.pagination').text("Please wait...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});
