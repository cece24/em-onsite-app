document.addEventListener('DOMContentLoaded', function() {
  var livePollButtons = document.querySelectorAll('.live-poll-button');
  var questionButtons = document.querySelectorAll('.ask-a-question-button');
  var pollContainers = document.querySelectorAll('.poll-container');
  var questionContainers = document.querySelectorAll('.question-container');

  for (var i = 0; i < pollContainers.length; i++) {
    pollContainers[i].style.display = "none";
    questionContainers[i].style.display = "none";
  }

  for (var i = 0; i < livePollButtons.length; i++ ) {
    livePollButtons[i].addEventListener('click', function(e) {
      console.log('click');
      var sessionClass = this.classList[0];
      var pollContainer = $('.poll-container.' + sessionClass);

      if (pollContainer[0].style.display == "none") {
        pollContainer[0].style.display = "block";
      } else {
        pollContainer[0].style.display = "none";
      }
    })
  }

  for (var i = 0; i < questionButtons.length; i++ ) {
    questionButtons[i].addEventListener('click', function(e) {
      console.log('click');
      var sessionClass = this.classList[0];
      var questionContainer = $('.question-container.' + sessionClass);

      if (questionContainer[0].style.display == "none") {
        questionContainer[0].style.display = "block";
      } else {
        questionContainer[0].style.display = "none";
      }
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
