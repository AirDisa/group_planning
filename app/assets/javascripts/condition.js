addPunctuation = function(input){
  var sentence_length = $('#sentence').children("span").length;
  if (sentence_length <= 4) {
    $(input).after(', and if');
  } else {
    $('#sentence').append('.');
  }
};

$(document).ready(function() {

  // in general, youre performing event delegation by listening for events on body -- you can optimize your javascript a bit by listening on an element narrower in scope than body

  //Transition and posting between yes, yes-if, no.
  $('body').on('click', '.cond_buttons button', function(){
    var screen = $(this).attr('id')
    var id = $(this).data('invitee_id');
    if (screen === 'Yes') {
      $.post('/invitees/'+id, {status: 'Yes'} , function(){
        $('.conditional').hide();
        $('.yes').animate({ width: 'show' });
      });
    } else if (screen ==='yes_if') {
      $('.conditional').hide();
      $('.yes_if').animate({ width: 'show' });
    } else if (screen === 'No') {
      $.post('/invitees/'+id, {status: 'No'} , function(){
        $('.conditional').hide();
        $('.no').animate({ width: 'show' });
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
    });
  });

  //closes message window
  $('body').on('click', '#close_window', function(){
    $(this).parent().fadeOut();
  });

  // Drop down for conditions
  $('body').on('click', '#condition_link', function(e){
    e.preventDefault();
    $('#condition_list').slideDown('fast');
  });

  $('body').on('click', '#number_of_people', function(e){
    e.preventDefault();
    $('#sentence').append($('#minNumSelection'));
    $('#number_of_people').hide();
    $('#condition_list').hide();
  });

  $('body').on('click', '#certain_person_goes', function(e){
    e.preventDefault();
    var person = $('#personSelection').clone();
    $('#sentence').append(person);
    $('#condition_list').hide();
  });
});
