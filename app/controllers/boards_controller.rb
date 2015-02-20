class BoardsController < ApplicationController

  def update_progress

    @board_card = Board.find(params[:id])
    @board_card.validate_board_state

    respond_to do |format|
      
      format.html { redirect_to(game_path(@board_card.game_id)) }

      format.json { render :json => @board_card }
      
    end    

  end

end