class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_user_library, only: [:library]


  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create!(user_params)
    render json: @user, status: :created
  end

  def show
    render json: @user
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def library
    render json: (Movie.alive_by_user(@user.id) + Season.alive_by_user(@user.id)).sort{|a,b| a.end_at <=> b.end_at }, only: :title
  end

  private

  def user_params
    params.permit(:email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_library
    @user = User.find(params[:user_id])
  end

end
