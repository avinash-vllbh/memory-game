class CardsController < ApplicationController
  before_filter :check_if_admin
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:info] = "New card is successfully created"
      redirect_to cards_path
    else
      # flash[:alert] = "failed to create new card"
      render "new"
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      flash[:info] = "Card has been successfully updated"
      redirect_to cards_path
    else
      # flash[:alert] = "failed to update the card"
      render "edit"
    end
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to cards_path
  end

  private
    def card_params
      params.require(:card).permit(:content)
    end
end
