# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PasswordReset', type: :request do

  describe 'POST /password_reset' do
    it 'Generate password reset' do
      @user = create(:user)
      post password_reset_path, params: {
        password_reset: { email: @user.email }
      }
      expect(response).to have_http_status(201)
    end
  end
end
