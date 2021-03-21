class PurchasesController < ApplicationController
  before_action :set_user
  before_action :set_purchase, only: [:show, :update, :destroy]

  def index
    render json: @user.purchases
  end

  def show
    render json: @purchase
  end

  def create
    begin
      @user.purchases.create!(purchase_params)
      render json: purchase_params, status: :created
    rescue StandardError => e
      if e.message.include?("User has already been taken")
        render json: {error: "The #{purchase_params[:purchasable_type]} is already in your library.", status: 400}, status: :bad_request
      else
        render json: {error: e.message, status: 422}, status: :unprocessable_entity
      end
    end
  end

  def update
    @purchase.update(purchase_params)
    head :no_content
  end

  def destroy
    @purchase.destroy
    head :no_content
  end

  private

  def purchase_params
    params.permit(:quality, :price, :purchasable_id, :purchasable_type, :user_id, :begin_at, :end_at)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_purchase
    @purchase = @user.purchases.find_by!(id: params[:id]) if @user
  end
end
