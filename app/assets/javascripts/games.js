$( document ).ready(function() {
  /* attach a submit handler to the form */
  $("#notify-form").submit(function(event) {
    event.preventDefault(); //STOP default action
    var postData = $(this).serializeArray();
    // Also add the url which the user needs to be continue his progress
    postData.push({name: "url", value: $("#progressLink").attr("href")});
    console.log(postData);
    $.ajax({
      url : "/notify_user",
      type: "POST",
      data : postData,
      success: function(){
        console.log("Email sent to user");
      }
    });
  });
});
