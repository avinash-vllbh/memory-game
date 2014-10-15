class GamesController < ApplicationController
  def index
    cards_collection = []
    @game = Game.new
    board_size = @game.board_size
    cards = Card.pluck(:content) # Return only content column of cards table.
    # If board size is 16 (no of cards on board = 16) => Total pairs on board 8
    @game.total_pairs = board_size/2
    # Each element being added to the board should be added in pairs
    (@game.total_pairs).times do
      card = cards.sample # pick one card randomly from all the cards available
      2.times { cards_collection << card } # Each card is appeneded to the array twice
    end
    cards_collection.shuffle! # Randomize the collection in place as the board need to be randomized for each new game
    # create a new board
    board = []
    cards_collection.each_with_index do |card,index|
      board.push({"id" => index + 1, "card" => card})
    end
    @game.board = board
    @game.save!
    @hostname = request.host
    @port = request.port
  end

  def show
  end

  def update
  end
end
