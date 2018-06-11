# frozen_string_literal: true

# Webhook controller for hardfail emails
class WebhookController < ApplicationController
  def handle
    user = User.find_by(email: params[:payload][:message][:to])
    case params[:payload][:status]
    when 'HardFail'
      user.email = nil
      user.password = user.document.to_s
      user.save(validate: false)
    end
    render json: { ok: true }
  end
end
