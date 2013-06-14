$(document).ready(function() {
  $('.draggable-options li').draggable({
    helper: "clone",
    appendTo: "body",
    addClasses: false
  });

  $('.droppable-options').droppable({
    drop: function(event, ui) {
      // debugger;
      if (ui.draggable.attr('id') === 'min_num') {
        $(this).before( $('#minNumSelection').html() );
      } else if (ui.draggable.attr('id') === 'person') {
        $(this).before( $('#personSelection').html() );
      }
    }
  });
});
