class GamesController < ApplicationController

  def index
    @games = current_user.games
  end

  def create
    @game = Game.create
    @game.user_id = current_user.id
    @game.save
    redirect_to @game
  end
  
  def show
    @game = Game.find(params[:id])
    unless @game.user == current_user
      flash[:alert] = "Cannot play someone's game!! Can you??"
      redirect_to games_path
    end
    @game_board = @game.game_board
  end

  ###
  # Update game preferences
  def update
    @game = Game.find(params[:id])
    @game.update_preferences(game_params)
    if @game.errors.empty?
      flash[:notice] = "Your game preferences have been successfully updated!"
    else
      flash[:alert] = @game.errors[:base].to_sentence
    end
    redirect_to @game
  end

  ###
  # Respond with game as only json
  def counters
    @game = Game.find(params[:id])
    unless @game.user == current_user
      render json: nil, status: 422
    else
      render json: @game, status: 200
    end
  end

  # def notify_user
  #   if UserMailer.notify_email(params[:email], params[:url]).deliver
  #     render json: nil, status: 200
  #   else
  #     render json: nil, status: 422
  #   end
  # end

  private

  def game_params
    params.require(:game).permit(:id, :grid_size, :difficulty)
  end
end
