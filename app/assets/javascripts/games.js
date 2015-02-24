/*
 * Register submit event on #notify-form form
 * Stop default action - to submit a post to backend
 * Gets the form data, serializes it add the url that needs to sent as email
 */
$(document).on('ready page:load', function() {
  /* attach a submit handler to the form */
  $("#notify-form").submit(function(event) {
    event.preventDefault(); //STOP default action
    var postData = $(this).serializeArray();
    // Also add the url which the user needs to be continue his progress
    postData.push({
      name: "url",
      value: $(".progressLink").attr("href")
    });
    $.ajax({
      url: "/notify_user",
      type: "POST",
      data: postData,
      success: function() {
        // notify user
        pushNotifications("alert alert-success", "Email has been sent successfully");
      }
    });
  });
});

/*
 * Displays notifications at the top of the main wrapper
 * Removes the notification after 1 sec
 * @param {String} type
 * @param {String} text
 */
function pushNotifications(type, text) {
  var html = "<div class='" + type + "'>" + text + "</div>";
  // Display alert
  $(html).hide().prependTo("#wrapper").fadeIn(300);
  // Remove the alert slowly
  setTimeout(function() {
    $(".alert").hide('slow', function() {
      $(".alert").remove();
    });
  }, 2000);
}
