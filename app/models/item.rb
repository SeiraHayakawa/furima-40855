class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :fee
  belongs_to :institution
  belongs_to :situation
  belongs_to :Prefecture

  
  validates :item_name, :introduction, :image, :price, presence: true


  validates :category_id, :situation_id, :fee_id, :prefecture_id, :institution_id, numericality: { other_than: 1, message: "can't be blank" } 

end


