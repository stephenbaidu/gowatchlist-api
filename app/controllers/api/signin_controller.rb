class Api::SigninController < Api::BaseController
  skip_before_action :authorize_access_request!, only: [:create]

  def create
    user = User.find_by!(email: signin_params[:email])
    if user.authenticate(signin_params[:password])
      payload  = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(
        JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?
      )

      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    head :ok
  end

  private

  def signin_params
    params.require(:signin).permit(:email, :password)
  end
end
