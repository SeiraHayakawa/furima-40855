class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]

  def index
    if @item.buyer.nil?
      if current_user.id == @item.user_id
        redirect_to root_path
      end
    else
      redirect_to root_path    
    end

    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @buyer_address = BuyerAddress.new
  end

  def create
    @buyer_address = BuyerAddress.new(buyer_address_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index
    end
  end

  private

  def buyer_address_params
    params.require(:buyer_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number ).merge(user_id: current_user.id, item_id: params[:item_id] , token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_address_params[:token],
      currency: 'jpy'
    )
  end
end

