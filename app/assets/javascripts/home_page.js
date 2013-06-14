$(document).ready(function(){

  // Hide Forms on Page Load
  $('.log_in_form').hide();
  $('.join_form').hide();

  // Truncate intro paragraph on Page Load
  $('#home_hover').hide();

  // Show entire intro paragraph on hover
  $('#home_intro').mouseover(function(){
    $('#home_hover').delay(200).fadeToggle();
  });

  $('#home_intro').mouseout(function(){
    $('#home_hover').toggle();
  });

  // Toggle login form on click
  $('a.home_login').click(function(){
    $('.log_in_form').delay(500).fadeToggle();
    toggleLinks();
  });

  // Toggle join form on click
  $('a.home_join').click(function(){
    $('.join_form').delay(500).fadeToggle();
    toggleLinks();
  });

  // Close forms with link
  $('.home_form_close').click(function(event){
    scrollTop();
    $(this).parent().delay(500).fadeToggle();
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
}
