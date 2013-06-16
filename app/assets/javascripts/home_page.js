$(document).ready(function(){

  // Hide Forms on Page Load
  $('.log_in_form').hide();
  $('.join_form').hide();

  // Toggle login form on click
  $('a.home_login').click(function(event){
    $('.log_in_form').delay(500).fadeToggle();
    $('#home_hover').delay(100).fadeToggle();
    toggleLinks();
    event.preventDefault();
  });

  // Toggle join form on click
  $('a.home_join').click(function(event){
    $('.join_form').delay(500).fadeToggle();
    $('#home_hover').delay(100).fadeToggle();
    toggleLinks();
    event.preventDefault();
  });

  // Close forms with link
  $('.home_form_close').click(function(event){
    scrollTop();
    $(this).parent().delay(100).fadeToggle();
    $('#home_hover').delay(500).fadeToggle();
    toggleLinks();
    event.preventDefault();
  });

});

var toggleLinks = function() {
  $('#home_form_links').delay(500).fadeToggle();
};

var scrollTop = function() {
  $('body,html').animate({
    scrollTop: 0
  }, 500);
};