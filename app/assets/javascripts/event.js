var inviteeEmail = function(index) {
  return "<input id='event_emails"+index+"' name='event[emails]["+index+"]'\
  placeholder='Invitee&#x27;s email' size='30' type='text' class='friend-email' />";
};

$(document).ready(function(){
  $('#create_event #next').click(function(){
    $('ul#errors').html('');
    if ( ($('#event_title').val() != '') && ($('#event_commit_date').val() != '')) {
    $('.wrapper.event-creation').toggle("slide");
  } else { $('ul#errors').append('<li class="email">You Must Have an Event Title and Commit Date</li>').hide().slideDown(100)}
  });

  $('#create_event #add').click(function(){
    var index = $('#emails input').length;
    $('#emails input').last().after(inviteeEmail(index));
  });

  if ($('#timeToCommit').length != 0) {
  var commitTime = $('#timeToCommit').data('commitdate');
  var timeToCommit = countdown( new Date(commitTime*1000), function(ts) {
      document.getElementById('timeToCommit').innerHTML = ts.toHTML("strong");
    }, countdown.WEEKS|countdown.DAYS|countdown.HOURS|countdown.MINUTES);
  }

  $('.event_info').on('submit', '.post_a_comment', function(e){
    e.preventDefault();
    var data = $(this).serialize();
    $.post('/comments', data, function(event){
      results = $(event).find('#comment_area').html();
      $('#comment_area').html(results);
      $('form.post_a_comment')[0].reset();
    });
  });
});

