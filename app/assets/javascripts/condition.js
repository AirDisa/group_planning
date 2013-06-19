addPunctuation = function(input){
  var sentence_length = $('#sentence').children("span").length;
  if (sentence_length <= 4) {
    $(input).after(', and if');
  } else {
    $('#sentence').append('.');
  }
};

var counter = 0

$(document).ready(function() {

  //Transition and posting between yes, yes-if, no.
  $('.cond_buttons button').click(function(){
    var screen = $(this).attr('id')
    var id = $(this).data('invitee_id');
    if (screen === 'Yes') {
      $.post('/invitees/'+id, {status: 'Yes'} , function(){
        ajaxSide();
        $('.conditional').fadeOut();
        $('.yes').fadeIn();
      });
    } else if (screen ==='yes_if') {
      $('.conditional').fadeOut();
      $('.yes_if').fadeIn();
    } else if (screen === 'No') {
      $.post('/invitees/'+id, {status: 'No'} , function(){
        ajaxSide();
        $('.conditional').fadeOut();
        $('.no').fadeIn();
      });
    }
  });

  // Handling the commit on yes-if.
  $('.wrapper').on('click', '#condition_button', function(e){
    e.preventDefault();
    var data = $('form').serialize();
    $.post('/conditions', data, function(){
      ajaxSide();
      $('.yes_if').fadeOut();
      $('.thanks').fadeIn();
    });
  });

  //closes message window
  $('.wrapper').on('click', '#close_window', function(){
    $(this).parent().fadeOut();
  });

  // Drop down for conditions
  $('.wrapper').on('click', '#condition_link', function(e){
    e.preventDefault();
    $('#condition_list').slideToggle();
  });

  $('.wrapper').on('click', '#number_of_people', function(e){
    e.preventDefault();
    counter ++;
    $('span.condition-dropdown').before($('#minNumSelection')).before('and if');
    $('#number_of_people').hide();
    $('#condition_list').hide();
  });

  $('.wrapper').on('click', '#certain_person_goes', function(e){
    e.preventDefault();
    counter ++;
    if (counter == 3) {
      var person = $('#personSelection').clone();
      $('span.condition-dropdown').before(person).before('.');
      $('#condition_list').hide();
      $('#condition_link').remove();
    } else {
      var person = $('#personSelection').clone();
      $('span.condition-dropdown').before(person).before('and if');
      $('#condition_list').hide();
    }
  });
});

var ajaxSide = function() {
  var eventURL = $('.wrapper').attr('id');
    $.get('/events/' + eventURL, function(response){
      var results = $(response).find('.vertical').html();
      $('.vertical').html(results);
    });
}