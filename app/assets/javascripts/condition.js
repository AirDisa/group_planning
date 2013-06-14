$(document).ready(function() {
  $('.draggable-options li').draggable({
    helper: "clone",
    appendTo: "body",
    addClasses: false
  });

  $('.droppable-options').droppable({
    drop: function(event, ui) {
      if (ui.draggable.attr('id') === 'min_num') {
        $(this).before( $('#minNumSelection').html() );
        $('#min_num').remove();
        addPunctuation($('#min_people'));
      } else if (ui.draggable.attr('id') === 'person') {
        $(this).before( $('#personSelection').html() );
        addPunctuation($('#person_selector'));
      };
    }
  });

  addPunctuation = function(input){
    var sentence_length = $('#sentence').children("span").length; 
    if (sentence_length <= 3) {
      $(input).after(', and if');
    } else {
      $('#sentence').append('.');
      $('.droppable-options').remove();
    }
  }
});
