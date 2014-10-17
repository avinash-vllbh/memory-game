  require 'rails_helper'
require 'pry'
RSpec.describe CardsController, :type => :controller do

  it "blocks unauthenticated access to all actions" do
    get :index
    expect(response).to redirect_to(new_user_session_path)
  end
  describe "when signed in as admin" do
    fixtures :users
    before (:each) do
      user = users(:admin)
      sign_in user
    end
    describe "GET index" do
    fixtures :cards
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "returns a list of cards" do
      cards = []
      cards.push(cards(:square))
      cards.push(cards(:circle))
      cards.push(cards(:pentagon))
      get :index
      expect(assigns(:cards)).to eq(cards)
    end
  end

  describe "POST create" do
    it "raises exception when params are missing" do
      expect{ post(:create, {}) }.to raise_error ActionController::ParameterMissing
    end
    it "can successfully create a new contact" do
      expect{ post(:create, card: {content: "hexagon"})}.to change{Card.count}.by(1)
    end
    it "redirects to index when successful" do
      post :create, card: {content: "hexagon"}
      expect(response).to redirect_to(cards_path)
    end
  end

  # describe "GET new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  end

end
