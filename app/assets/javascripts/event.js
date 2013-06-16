var inviteeEmail = function(index) {
  return "<input id='event_emails"+index+"' name='event[emails]["+index+"]'\
  placeholder='Invitee&#x27;s email' size='30' type='text' class='friend-email' />";
};

$(document).ready(function(){
  $('#create_event #next').click(function(){
    $('.wrapper.event-creation').toggle("slide");
  });

  $('#create_event #add').click(function(){
    var index = $('#emails input').length;
    $('#emails input').last().after(inviteeEmail(index));
  });

  var commitTime = $('#timeToCommit').data('commitdate');
  var timeToCommit = countdown( new Date(commitTime*1000), function(ts) {
      document.getElementById('timeToCommit').innerHTML = ts.toHTML("strong");
    }, countdown.WEEKS|countdown.DAYS|countdown.HOURS|countdown.MINUTES);
});
