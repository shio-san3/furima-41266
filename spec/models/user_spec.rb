require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '異常系' do
      it '英字のみのpasswordでは登録できない' do
        @user = User.new(password: 'abcdef', password_confirmation: 'abcdef')
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it '数字のみのpasswordでは登録できない' do
        @user = User.new(password: '123456', password_confirmation: '123456')
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it '全角文字を含むpasswordでは登録できない' do
        @user = User.new(password: 'ａｂｃ123', password_confirmation: 'ａｂｃ123')
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it 'last_nameに半角文字が含まれていると登録できない' do
        @user = User.new(last_name: 'Sato')
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be full-width characters (kanji, hiragana, katakana)')
      end

      it 'first_nameに半角文字が含まれていると登録できない' do
        @user = User.new(first_name: 'Taro')
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be full-width characters (kanji, hiragana, katakana)')
      end

      it 'last_name_kanaにカタカナ以外の文字が含まれていると登録できない' do
        @user = User.new(last_name_kana: 'さとう')
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be full-width katakana characters')
      end

      it 'first_name_kanaにカタカナ以外の文字が含まれていると登録できない' do
        @user = User.new(first_name_kana: 'たろう')
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be full-width katakana characters')
      end
    end
  end
end