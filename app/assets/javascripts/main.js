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

});
