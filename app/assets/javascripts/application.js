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

$( document ).ready(function() {
  // To flip the cards - when user comes back to his progress
  $(function(){
    if (typeof progress !== 'undefined' && progress.length > 0) {
      progress.forEach(function(id) {
        $(".cards#"+id).html(board[id].card).addClass("flipped");
      });
    }
  });

  $(".cards").click(function() {
    // check if it's not already selected
    if(!$(this).hasClass("selected")) {
      // Check if any other card has already been flipped
      if($(".cards.selected").length) {
        var prevCardId = $(".cards.selected").attr("id");
      }
      // Get current element's attribute-id and show it's content
      // Add selected class to it
      var currentCardId = $(this).attr("id");
      $(this).html(board[currentCardId].card).show(300).addClass("selected");
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
      console.log("progress saved to backend");
    }
  });
}




