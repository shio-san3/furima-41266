require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常系' do
      it 'すべての属性が正しく入力されていると登録できる' do
        user = User.new(
          name: 'test',
          email: 'test@example.com',
          password: 'Password1',  # 数字と文字を含むパスワード
          password_confirmation: 'Password1',
          last_name: '佐藤',  # 必要な属性
          first_name: '太郎',  # 必要な属性
          last_name_kana: 'サトウ',  # 必要な属性
          first_name_kana: 'タロウ',  # 必要な属性
          birth_date: Date.new(1995, 5, 5)  # 必要な属性
        )
        expect(user).to be_valid
      end
    end

    context '異常系' do
      it 'nameが空では登録できない' do
        user = User.new(
          name: '',
          email: 'test@example.com',
          password: 'Password1',
          password_confirmation: 'Password1',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include("Name can't be blank")
      end

      it 'emailが空では登録できない' do
        user = User.new(
          name: 'test',
          email: '',
          password: 'Password1',
          password_confirmation: 'Password1',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが不正な形式では登録できない' do
        user = User.new(
          name: 'test',
          email: 'invalid_email',
          password: 'Password1',
          password_confirmation: 'Password1',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        user = User.new(
          name: 'test',
          email: 'test@example.com',
          password: '',
          password_confirmation: '',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        user = User.new(
          name: 'test',
          email: 'test@example.com',
          password: '12345',
          password_confirmation: '12345',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        user = User.new(
          name: 'test',
          email: 'test@example.com',
          password: 'Password1',
          password_confirmation: 'Password2',
          last_name: '佐藤',
          first_name: '太郎',
          last_name_kana: 'サトウ',
          first_name_kana: 'タロウ',
          birth_date: Date.new(1995, 5, 5)
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end