class Address < ApplicationRecord
  belongs_to :buyer

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end
