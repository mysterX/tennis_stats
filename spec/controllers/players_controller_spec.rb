require 'rails_helper'

describe PlayersController, :type => :controller do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      # Replacing old .should syntax with newer expect style
      expect(response).to be_success
#      response.should be_success
    end
  end

end
