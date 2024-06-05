class BuyerAddress  
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/ }
    validates :city
    validates :address
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :user_id
    validates :item_id
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, buyer_id: buyer.id)
  end
end