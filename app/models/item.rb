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

  
  validates :item_name, :institution, :price, presence: true


  validates :category_id, :situation_id, :fee_id, :prefecture_id, :institution_id, numericality: { other_than: 1, message: "can't be blank" } 

end


create_table :items do |t|
  t.string :item_name, null: false 
  t.text :introduction, null: false
  t.integer :category_id, null: false
  t.integer :situation_id, null: false
  t.integer :fee_id, null: false
  t.integer :prefecture_id, null: false
  t.integer :institution_id, null: false
  t.integer :price, null: false
  t.references :user, null: false, foreign_key: true

  t.timestamps
end