document.addEventListener('DOMContentLoaded', function() {
  var scheduleCheckbox = document.querySelector('input[name="scheduled"]');
  var scheduleAlertOptions = document.querySelector('.schedule-alert-options');
  var sendButton = document.querySelector('input[name="commit"]');

  console.log('alerts.js at werk');

  scheduleAlertOptions.style.display = "none";

  scheduleCheckbox.addEventListener('change', function() {
    if (this.checked) {
      scheduleAlertOptions.style.display = "unset";
      sendButton.dataset.confirm = "You are about to schedule an announcement that will be sent to all users of the event app. Are you sure you want to schedule this announcement?";
    } else {
      scheduleAlertOptions.style.display = "none";
    }
  })

})
