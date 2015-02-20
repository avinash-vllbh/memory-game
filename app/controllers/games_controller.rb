class GamesController < ApplicationController

  def index
    @games = current_user.games
  end

  def new
    @game = Game.create
    ###
    # Saving the user_id association in controller
    # Model are not supposed to have the state information of current_user
    @game.user_id = current_user.id
    @game.save
    # @game_board = @game.game_board
    # Refreshing when on new game view would cause to create a new game
    redirect_to @game
  end

  def create

  end
  
  def show
    @game = Game.find(params[:id])
    @game_board = @game.game_board
  end

  ###
  # Update game preferences
  def update
    @game = Game.find(params[:id])
    if @game.update_preferences(game_params)
      flash[:notice] = "Your game preferences have been successfully updated!"
    else
      flash[:alert] = "Your game preferences have not been updated!"
    end
    redirect_to @game
  end

  def notify_user
    if UserMailer.notify_email(params[:email], params[:url]).deliver
      render json: nil, status: 200
    else
      render json: nil, status: 422
    end
  end

  private

  def game_params
    params.require(:game).permit(:id, :grid_size, :difficulty)
  end
end
