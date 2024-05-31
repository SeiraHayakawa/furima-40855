class Item < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :fee
  belongs_to :institution
  belongs_to :situation
  belongs_to :prefecture


  validates :item_name, presence: true, length: { maximum: 40 }
  validates :introduction, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, message: "must be a half-width number" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "must be between ¥300 and ¥9,999,999" }


  validates :category_id, :situation_id, :fee_id, :prefecture_id, :institution_id, numericality: { other_than: 1, message: "can't be blank" } 

end


