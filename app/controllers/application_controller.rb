class ApplicationController < ActionController::API
  before_action :authenticate

  def authenticate
    authorization_header = request.headers['Authorization']
    if authorization_header.present? && authorization_header.start_with?('Bearer ')
      bearer_token = authorization_header.split(' ').last  # Extract the token
      begin
        @auth_header = bearer_token
        decode_token = JWT.decode(token, secret)
        payload = decode_token.first
        user_id = payload["user_id"]
        @current_user = User.find(user_id)
      rescue => exception
        render json: { message: "Error: #{exception}" }, status: :forbidden
      end
    else
      render json: { message: "No Authorization header sent" }, status: :forbidden
    end
  end

  def token
    @auth_header
  end

  def secret
    secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def create_token(payload)
    JWT.encode(payload, secret)
  end

  def current_user
    @current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    render status: 401, json: { success: false, errors: [exception.message] }
  end

  rescue_from CanCan::Error do |exception|
    render status: 401, json: { success: false, errors: [exception.message] }
  end
end
