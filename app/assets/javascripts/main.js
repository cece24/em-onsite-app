document.addEventListener('DOMContentLoaded', function() {

  if (document.body.classList[0] == "sessions-new" || document.body.classList[0] == "events-show") {
    var contactSupportLink = document.querySelector(".contact-support");
    var contactModal = document.querySelector(".modal-container");
    var closeModal = document.querySelector(".contact-close")

    contactSupportLink.addEventListener('touchstart', function(e) {
      e.preventDefault();

      contactModal.style.display = "block";

      closeModal.addEventListener('click', function() {
        contactModal.style.display = "none";
      });
    });

    contactSupportLink.addEventListener('click', function(e) {
      e.preventDefault();

      contactModal.style.display = "unset";

      closeModal.addEventListener('click', function() {
        contactModal.style.display = "none";
      });
    });
  }

  if (document.body.classList[0] == "session_details-index") {
    setInterval(function() {
      $.ajax({ url: 'https://core.eventmobi.com/cms/v1/events/liveresults/questions?event_id=21555&hash=d8fc7271bd60311e22fab6dbadd24cf2d72ba4cb1f583fe14f809bff4744245d&question_id=348574&question_type=live_poll&session_id=5d44d348-aa74-49bf-8466-1acd5573c038',
      method: 'GET',
      dataType: 'json'
    }).done(function(data) {
      console.log(data);
    })
  }, 500)
  }

});
