$(document).ready(function(){

  // Hide Forms on Page Load
  $('.log_in_form').hide();
  $('.join_form').hide();

  // Truncate intro paragraph on Page Load
  $('#home_hover').hide();

  // Show entire intro paragraph on hover
  $('#home_intro').hover(function(){
    $('#home_hover').toggle();
  });

  // Toggle login form on click
  $('a.home_login').click(function(){
    $('.log_in_form').toggle();
    toggleLinks();
  });

  // Toggle join form on click
  $('a.home_join').click(function(){
    $('.join_form').toggle();
    toggleLinks();
  });

  // Close login form with link
  $('.home_form_close').click(function(){
    $(this).parent().toggle();
    toggleLinks();
  });

});

var toggleLinks = function() {
  $('#home_form_links').toggle();
};