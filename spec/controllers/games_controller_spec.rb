require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  describe "GET index" do
    fixtures :games
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "creates a new game when index page is loaded" do
      #change matcher expects a block to be passed to it
      expect{ get :index }.to change{ Game.count }.by(1)
    end
  end

  describe "GET show" do
    fixtures :games
    it "returns http success" do
      get :show, id: games(:sample)
      expect(response).to have_http_status(:success)
    end
    it "assigns requested game to @game" do
      game = games(:played)
      get :show, id: games(:played)
      # check whether @game instace variable assigned by controller is as expected
      expect(assigns(:game)).to eq(game) 
    end
    it "retains state of game, so that visitor can come back to it" do
      game = games(:played)
      get :show, id: games(:played)
      expect(assigns(:game).flipped).to eq(game.flipped) 
    end
  end

  describe "PUT update" do
    fixtures :games
    let(:game_progress) {["1","2"]}
    it "updates the user progress of the game" do
      get :update, id: games(:sample), progress: ["1","2"]
      expect(assigns(:game).flipped).to eq(game_progress)
    end
    it "updates the pairs_found attribute based on user progress of the game" do
      get :update, id: games(:sample), progress: ["1","2"]
      expect(assigns(:game).pairs_found).to eq(1)
    end
  end

  describe "#notify_user" do
    post :notify_user, {:email => "test@test.com", :url => "memorygame-demo.herokuapp.com/games/a1243-123123-asd1233fasdef"}
    expect(response).to respond_with 200
  end
end
