//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= requre jquery.ui.all
//= require best_in_place
//= require pickadate/picker
//= require pickadate/picker.date
//= require_tree .

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  
 $(function() {
    $(".slider").jCarouselLite({
      btnNext: ".next",
      btnPrev: ".prev",
      visible: 1
    });

    $('img.captify').captify({
    // all of these options are... optional
    // speed of the mouseover effect
    speedOver: 'fast',
    // speed of the mouseout effect
    speedOut: 'normal',
    // how long to delay the hiding of the caption after mouseout (ms)
    hideDelay: 500,
    // 'fade', 'slide', 'always-on'
    animation: 'slide',
    // text/html to be placed at the beginning of every caption
    prefix: '',
    // opacity of the caption on mouse over
    opacity: '0.7',
    // the name of the CSS class to apply to the caption box
    className: 'caption-bottom',
    // position of the caption (top or bottom)
    position: 'bottom',
    // caption span % of the image
    spanWidth: '100%'
  });
  });
});

