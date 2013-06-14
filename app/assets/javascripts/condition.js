$(document).ready(function() {

//describes the conditions and makes them draggable.

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


//Transition and posting between yes, yes-if, no.
  $('body').on('click', 'button', function(){
    var screen = $(this).attr('id')
    var id = $(this).data('invitee_id');
    if (screen === 'Yes') {
      $.post('/invitees/update/'+id, {status: 'Yes'} , function(){
      $('.conditional').hide();
      $('.yes').animate({ width: 'show' });
      $('.yes').delay(2000).fadeOut();
      });
    } else if (screen ==='yes_if') {
      $('.conditional').hide();
      $('.yes_if').animate({ width: 'show' });
    } else if (screen === 'No') {
      $.post('/invitees/update/'+id, {status: 'No'} , function(){
      $('.conditional').hide();
      $('.no').animate({ width: 'show' });
      $('.no').delay(2000).fadeOut();
    });
    }
  });

// Handling the commit on yes-if.
  $('body').on('click', '#condition_button', function(e){
  e.preventDefault();
  var data = $('form').serialize();
  $.post('/conditions', data, function(){
    $('.yes_if').hide();
     $('.thanks').animate({ width: 'show' });
      $('.thanks').delay(2000).fadeOut();
    });
  });
});
