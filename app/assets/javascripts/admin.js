$(function() {
  $('.user_admin_nav a').bind('click', function(event){
    var $anchor = $(this);
    debugger

    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href')).offset().top
    }, 1000);

    event.preventDefault();
  });
});