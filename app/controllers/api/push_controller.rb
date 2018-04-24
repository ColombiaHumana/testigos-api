class Api::PushController < Api::ApiController

  def register
    current_user.update(push_token: params['token']['value'])
  end


  def push_params
      params.require(:token).permit(:value)
  end
end
