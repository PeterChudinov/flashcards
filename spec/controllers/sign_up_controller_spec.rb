require 'rails_helper'

RSpec.describe SignUpController, type: :controller do

  describe "GET #signup" do
    it "returns http success" do
      get :signup
      expect(response).to have_http_status(:success)
    end
  end

end
