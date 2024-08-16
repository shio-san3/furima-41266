require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nameが空だと登録できない' do
      user = User.new(
        name: '',  # nameが空の場合
        email: 'test@example.com',  # emailアドレス形式を修正
        password: '000000',
        password_confirmation: '000000',
        last_name: '佐藤',
        first_name: '太郎',
        last_name_kana: 'サトウ',
        first_name_kana:'タロウ',
        birth_date: Date.new(1995, 5, 5)
      )
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")  # nameに対応するエラーメッセージを確認
    end

    it 'emailが空では登録できない' do
      user = User.new(
        name: 'furima太郎',  # nameを使用
        email: '',  # emailを空に
        password: '000000',
        password_confirmation: '000000',
        last_name: '佐藤',
        first_name: '太郎',
        last_name_kana: 'サトウ',
        first_name_kana:'タロウ',
        birth_date: Date.new(1995, 5, 5)
      )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")  # emailに対応するエラーメッセージを確認
    end
  end
end