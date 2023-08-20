class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    @user = User.find_by(email: params[:user][:email])
    return render json: { message: "Please register first" } unless @user
    return render json: { message: "Authentication Failed" } unless authenticate_user

    payload = { user_id: @user.id, admin: @user.admin }
    token = create_token(payload)
    render json: { user: @user, token: token }
  end

  private

  def authenticate_user
    @user&.authenticate(params[:user][:password])
  end
end


