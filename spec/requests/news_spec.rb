require 'rails_helper'
def authenticated_header(user)
  token = Knock::AuthToken.new(payload: { sub: user.id }).token
  { 'Authorization': "Bearer #{token}" }
end
RSpec.describe "News", type: :request do
  before :all do
    @user = create(:user)
    @news1 = create(:news)
    @news2 = create(:news)
  end
  describe "GET /news" do
    it "get all news" do
      get news_index_path, headers: authenticated_header(@user)
      expect(response).to have_http_status(:ok)
    end

    it "refuse connection" do
      get news_index_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
