document.addEventListener('DOMContentLoaded', function() {
  // var manageContainers = document.querySelectorAll('.manage-container');
  var livePollButtons = document.querySelectorAll('.live-poll-button');
  var questionButtons = document.querySelectorAll('.ask-a-question-button');
  var livePollContainers = document.querySelectorAll('.poll-container');
  var questionContainers = document.querySelectorAll('.question-container');

  for (var i = 0; i < livePollButtons.length; i++ ) {
    livePollButtons[i].addEventListener('click', function(e) {
      livePollContainers[i].style.display = "unset";
    })
  }

  for (var i = 0; i < questionButtons.length; i++ ) {
    questionButtons[i].addEventListener('click', function(e) {
      questionContainers[i].style.display = "unset";
    })
  }

  // if (document.body.classList[0] == "session_details-index") {
  //   setInterval(function() {
  //     $.ajax({ url: 'https://core.eventmobi.com/cms/v1/events/liveresults/questions?event_id=21555&hash=d8fc7271bd60311e22fab6dbadd24cf2d72ba4cb1f583fe14f809bff4744245d&question_id=348574&question_type=live_poll&session_id=5d44d348-aa74-49bf-8466-1acd5573c038',
  //     method: 'GET',
  //     dataType: 'json'
  //   }).done(function(data) {
  //     console.log(data);
  //   })
  // }, 500)
  // }
})
