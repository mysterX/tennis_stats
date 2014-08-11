require 'rails_helper'

RSpec.describe RankingsController, :type => :controller do

  describe "GET missing_player" do
    it "returns http success" do
      get :missing_player
      expect(response).to be_success
    end
  end

  describe "GET missing_country" do
    it "returns http success" do
      get :missing_country
      expect(response).to be_success
    end
  end

end
