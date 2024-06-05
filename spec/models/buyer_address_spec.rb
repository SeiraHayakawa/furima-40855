require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @buyer_address = BuyerAddress.new(
      user_id: @user.id, item_id: @item.id, post_code: '123-4567', prefecture_id: 2,
      city: '横浜市緑区', address: '青山1-1-1', building_name: '柳ビル103', phone_number: '09012345678'
    )
  end

  describe '商品購入機能' do
    context '商品を購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@buyer_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        @buyer_address.building_name = ''
        expect(@buyer_address).to be_valid
      end
    end

    context '商品を購入できない場合' do
      it '郵便番号が空では購入できない' do
        @buyer_address.post_code = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号にハイフンが含まれていない場合は購入できない' do
        @buyer_address.post_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it '都道府県のidが1では購入できない' do
        @buyer_address.prefecture_id = 1
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できない' do
        @buyer_address.city = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @buyer_address.address = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        @buyer_address.phone_number = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にハイフンが含まれている場合は購入できない' do
        @buyer_address.phone_number = '090-1234-5678'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上では購入できない' do
        @buyer_address.phone_number = '090123456789'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'userが存在しない場合、購入できないこと' do
        @buyer_address.user_id = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが存在しない場合、購入できないこと' do
        @buyer_address.item_id = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end