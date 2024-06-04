class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @buyer = Buyer.create(buyer_params)
  end

  def create
    @buyer = Buyer.create(buyer_params)
    Address.create(address_params)
    redirect_to root_path
  end

  private

  def buyer_params
    params.permit(:price).merge(user_id: current_user.id)
  end

  def address_params
    params.permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(buyer_id: @buyer.id)
  end
end
