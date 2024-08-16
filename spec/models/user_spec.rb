require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
    user = User.new(
      name: '',
      email: 'test@example',
      password: '000000',
      password_confirmation: '000000',
      last_name: '佐藤',
      first_name: '太郎',
      last_name_kana: 'サトウ',
      first_name_kana:'タロウ',
      birth_date: Date.new(1995, 5, 5)
    )
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
    end
    it 'emailが空では登録できない' do
    user = User.new(
      name: 'furima太郎',
      email: '',
      password: '000000',
      password_confirmation: '000000',
      last_name: '佐藤',
      first_name: '太郎',
      last_name_kana: 'サトウ',
      first_name_kana:'タロウ',
      birth_date: Date.new(1995, 5, 5)
    )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
    end
  end
end