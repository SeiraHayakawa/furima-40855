require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do

    context '商品が出品できる場合' do
      it 'category_id、situation_id、fee_id、prefecture_id、institution_idが1意外の場合、尚且つitem_name、introduction、image、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    
    context '商品が出品できない場合' do
      it 'userが存在しない場合、商品が出品できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end

      it '商品画像が空欄の場合、商品が登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it '商品名が空欄の場合、商品が登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end

      it '商品の説明が空欄の場合、商品が登録できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Introduction can't be blank"
      end

      it 'カテゴリーが未選択の場合、商品が登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が未選択の場合、商品が登録できない' do
        @item.situation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Situation can't be blank"
      end

      it '配送料の負担が未選択の場合、商品が登録できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Fee can't be blank"
      end

      it '発送元の地域が未選択の場合、商品が登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '発送までの日数が未選択の場合、商品が登録できない' do
        @item.institution_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Institution can't be blank"
      end

      it '価格が空欄の場合、商品が登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it 'priceが299円以下の場合、商品が登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be between ¥300 and ¥9,999,999"
      end

      it 'praiceが10,000,000円以上の場合、商品が登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be between ¥300 and ¥9,999,999"
      end

      it '価格に全角数字が含まれている場合、商品が登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be a half-width number"
      end

      it 'item_nameが41文字以上の場合、登録ができない' do
        @item.item_name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name is too long (maximum is 40 characters)"
      end

      it 'introductionが1001文字以上の場合、登録ができない' do
        @item.introduction = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include "Introduction is too long (maximum is 1000 characters)"
      end

    end

  end
end
