class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :buyers


  with_options presence: true do
   validates :nickname
   validates :birth_day
  end


  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
    validates :first_name
    validates :family_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :first_name_kana
    validates :family_name_kana
  end

end
