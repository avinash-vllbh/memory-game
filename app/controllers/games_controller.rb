class GamesController < ApplicationController
  def index
    cards_collection = []
    @game = Game.new
    board_size = @game.board_size
    grid_size = Math.sqrt(@game.board_size)
    cards = Card.pluck(:content) # Return only content column of cards table.
    # If board size is 16 (no of cards on board = 16) => Total pairs on board 8
    @game.total_pairs = board_size/2
    # Each element being added to the board should be added in pairs
    # pick one card randomly from all the cards available
    # Each card is appeneded to the array twice
    (@game.total_pairs).times do
      card = cards.sample
      2.times { cards_collection << card }
    end
    cards_collection.shuffle! # Randomize the collection in place as the board need to be randomized for each new game
    # create a new board
    board = []
    cards_collection.each_with_index do |card,index|
      board.push({"id" => index, "card" => card})
    end
    @game.board = board
    @game.save!
    @hostname = request.host
  end

  def show
    @game = Game.find(params[:id])
    @hostname = request.host
  end

  def update
    @game = Game.find(params[:id])
    @game.flipped = params[:progress]
    @game.pairs_found = params[:progress].size/2
    if @game.save! # Bang to make sure it fails if an exception is found
      render json: nil, status: 200
    else
      render :json => {:errors => @contact.errors.messages}, :status => 422
    end
  end

  def notify_user
    UserMailer.notify_email(params[:email], params[:url]).deliver
    render json: nil, status: 200
  end
end
