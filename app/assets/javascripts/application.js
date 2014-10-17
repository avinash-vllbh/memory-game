// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require turbolinks
//= require_tree .

/*
* Registering events and functions that needs to be run
* These needs to be done on both document ready and page:load event
* Rails turbolinks - Makes any links on the page fire just page:load rather than ready.
*/
$( document ).on('ready page:load', function() {
  /* 
  * To flip the cards - when user comes back to his progress
  */
  $(function(){
    if (typeof progress !== 'undefined' && progress.length > 0) {
      progress.forEach(function(id) {
        $(".cards#"+id).html(board[id].card).addClass("flipped");
      });
    }
  });

  /* 
  * Register click event on div's with cards class
  * check if they are already selected or not and perform sequence of operatons.
  */
  $(".cards").click(function() {
    // check if it's not already selected 
    // to make sure only two cards can have class selected to them
    if(!$(this).hasClass("selected") && $(".cards.selected").length < 2) {
      // Check if any other card has already been flipped
      if($(".cards.selected").length) {
        var prevCardId = $(".cards.selected").attr("id");
      }
      // Get current element's attribute-id and show it's content
      // Add selected class to it
      var currentCardId = $(this).attr("id");
      $(this).html("<span class = 'pos-center'>" + board[currentCardId].card + "</span>").addClass("selected");
      $(this).find(".pos-center").fadeIn(500);
      if(prevCardId) {
        // Check if cards match
        if(board[currentCardId].card == board[prevCardId].card) {
          // Remove selected class from the elements and add flipped class
          $(".cards#"+currentCardId).removeClass("selected").addClass("flipped");
          $(".cards#"+prevCardId).removeClass("selected").addClass("flipped");
          updateProgress(currentCardId, prevCardId);
        } else {
          setTimeout(function() {
            $(".cards#"+currentCardId).html("").removeClass("selected");
            $(".cards#"+prevCardId).html("").removeClass("selected");
          }, 1000);
        }
      }
    } 
  });
});

/*
* Updates game progress to the backend seamlessly
* @param {Number} id1
* @param {Number} id2
*/
function updateProgress(id1, id2) {
  progress.push(id1);
  progress.push(id2);
  // Make an ajax call to games#update
  $.ajax({
    type: "PUT",
    url: "/games/"+game_id,
    dataType: "json",
    data: {progress: progress},
    success: function(){
    }
  });
}




