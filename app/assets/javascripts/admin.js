$(function() {
  $('.user_admin_nav a').on('click', function(event){
    var $anchor = $(this);

    $('html, body').stop().animate({
      scrollTop: $($anchor.attr('href')).offset().top
    }, 1000);

    event.preventDefault();
  });

  $('.datepicker').pickadate();
  $('.timepicker').pickatime();
});

$(document).ready(function(){
 $(function() {
    $(".slider").jCarouselLite({
      btnNext: ".next",
      btnPrev: ".prev",
      visible: 1
    });

    $('img.captify').captify({
      speedOver: 'fast',
      speedOut: 'normal',
      hideDelay: 500,
      animation: 'slide',
      prefix: '',
      opacity: '0.7',
      className: 'caption-bottom',
      position: 'bottom',
      spanWidth: '100%'
    });
  });
});
