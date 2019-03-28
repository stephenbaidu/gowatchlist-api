class V1::BaseController < ApplicationController
  include JWTSessions::RailsAuthorization

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotDestroyed, with: :unprocessable_entity

  before_action :authorize_access_request!
  
  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end
  
  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def record_not_found
    head :not_found
  end

  def unprocessable_entity(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
end
