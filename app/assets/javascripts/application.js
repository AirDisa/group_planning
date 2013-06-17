//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require best_in_place
//= require pickadate/picker
//= require pickadate/picker.date
//= require_tree .

// i would recommend moving this out of your manifest file
$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});

