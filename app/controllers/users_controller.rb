class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :check_admin, only: [:index]
  before_action :authenticate, except: [:create]
  load_and_authorize_resource except: [:create]


  # GET /users
  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    authorize! :destroy, @user
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end

    def check_admin
      render json: { message: "Not Authorized" }, status: :unauthorized unless current_user.admin
    end
end

