document.addEventListener('DOMContentLoaded', function() {

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

});
