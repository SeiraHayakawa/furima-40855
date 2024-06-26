class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    if @item.buyer.nil?
      if current_user.id != @item.user_id
        redirect_to root_path
      end
    else
      redirect_to root_path    
    end
  end

  def update
    if  @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :introduction, :category_id, :situation_id, :fee_id, :prefecture_id, :institution_id, :price, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end


end
