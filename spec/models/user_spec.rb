require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、family_nameとfirst_name、family_name_kanaとfirst_name_kana、birth_dayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it '名字(全角)が空では登録できない' do
        @user.family_name = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end

      it '名前(全角)が空では登録できない' do
        @user.first_name = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end

      it '名字のフリガナ(全角カナ)が空では登録できない' do
        @user.family_name_kana = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana can't be blank"
      end

      it '名前のフリガナ(全角カナ)が空では登録できない' do
        @user.first_name_kana = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end

      it '名字が全角以外では登録できない' do
        @user.family_name = 'aaaa'  
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name is invalid. Input full-width characters"
      end

      it '名前が全角以外では登録できない' do
        @user.first_name = 'aaaa'  
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid. Input full-width characters"
      end

      it '名字のフリガナが全角カナ以外では登録できない' do
        @user.family_name_kana = 'aaaa'  
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana is invalid. Input full-width katakana characters"
      end

      it '名前のフリガナが全角カナ以外では登録できない' do
        @user.first_name_kana = 'aaaa'  
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters"
      end

      it '誕生日が空では登録できない' do
        @user.birth_day = ''  
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth day can't be blank"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = '111111'  
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'  
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'  
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが全角文字を含むと登録できない' do
        @user.password = '１２３ａｂｃ' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
    end

  end
end
