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
$(document).on('ready page:load', function() {

  $("#main-nav a").click(function() {
    $("#main-nav").find(".active").removeClass("active");
    $(this).parent().addClass("active");
  });

  /* 
   * To flip the cards - when user comes back to his progress
   */
  $(function() {
    if (typeof progress !== 'undefined' && progress.length > 0) {
      progress.forEach(function(id) {
        $(".cards#" + id).html("<span class = 'pos-center'>" + board[id].card + "</span>").addClass("matched");
        $(".cards#" + id).find(".pos-center").fadeIn(500);
      });
      checkIfGameCompleted();
    }
  });

  /* 
   * Register click event on div's with cards class
   * check if they are already selected or not and perform sequence of operatons.
   */
  $(".cards").click(function() {

    if (!$(this).hasClass("selected") && $(".cards.selected").length < 2 && !$(this).hasClass("matched")) {
      var currentCardId = $(this).data("card-id");
      updateProgress(currentCardId);
    }

  });
});

/*
 * Updates game progress to the backend seamlessly
 * @param {Number} id1
 * @param {Number} id2
 */
function updateProgress(id) {

  $.ajax({
    type: "POST",
    url: "/board/update_progress",
    data: JSON.stringify({
      id: id
    }),
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function(data) {
      updateGameBoard(data);
    },
    failure: function(errMsg) {
      alert(errMsg);
    }
  });
}

/*
 * sets the cards state on the game board based on the response from the server
 */
function updateGameBoard(card) {

  var difficulty = {
    "easy": 1500,
    "medium": 1000,
    "hard": 600,
    "extra_hard": 300
  };

  var item = $(".cards[data-card-id=" + card.id + "]");
  // Display content of the card
  item.html("<span class = 'pos-center'>" + board[card.position].card_content + "</span>").addClass("selected");
  item.find(".pos-center").fadeIn(400);

  if (card.state == "origin") {
    // Reset the cards!!!
    setTimeout(function() {
      // Fade out the text inside the card and then remove the content
      $(".selected").each(function() {
        $(this).removeClass("selected").find(".pos-center").fadeOut(300, function() {
          $(this).html("");
        });
      });
    }, difficulty[game.difficulty]);

  } else if (card.state == "matched") {
    // Remove the class selected and change their state to changed
    $(".selected").each(function() {
      $(this).removeClass("selected").addClass("matched").attr('data-card-state', 'matched');
    });
  } else {
    // Do nothing
  }
  checkIfGameCompleted();
}


/*
 * Checks if game is completed and offer to start a new game
 */
function checkIfGameCompleted() {
  if ($(".matched").length == game.total_pairs * 2) {
    $('#game-completed').modal('show')
  }
}
