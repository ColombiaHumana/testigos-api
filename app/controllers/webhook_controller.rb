class WebhookController < ApplicationController
  def handle
    user = User.find_by(email: params[:message][:to])
    case params[:status]
    when "HardFail"
      user.email = nil
      user.password = user.document.to_s
      user.save(validate: false)
    end
    render json: {ok: true}
  end
end
