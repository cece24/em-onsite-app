document.addEventListener('DOMContentLoaded', function() {
  var scheduleCheckbox = document.querySelector('input[name="scheduled"]');
  var scheduleAlertOptions = document.querySelector('.schedule-alert-options');

  console.log('alerts.js at werk');

  scheduleAlertOptions.style.display = "none";

  scheduleCheckbox.addEventListener('change', function() {
    if (this.checked) {
      scheduleAlertOptions.style.display = "unset";
    } else {
      scheduleAlertOptions.style.display = "none";
    }
  })

})
