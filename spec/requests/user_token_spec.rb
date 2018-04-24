require 'rails_helper'

RSpec.describe "UserToken", type: :request do
  before :all do
    @user = create(:user)
  end
  describe "POST /user_tokens" do
    it "Receive JWT" do
      post user_token_path, params: { auth: { email: @user.email, password: "12345678" } }
      expect(response).to have_http_status(:created)
    end

    it "Denied access" do
      post user_token_path, params: { auth: { email: @user.email, password: "1234567" } }
      expect(response).to have_http_status(:not_found)
    end
  end
end
