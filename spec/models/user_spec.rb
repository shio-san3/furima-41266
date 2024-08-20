require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password").or include("does not match password")
      end

      it 'nameが7文字以上では登録できない' do
        @user.name = 'a' * 7
        @user.valid?
        expect(@user.errors[:name]).to include("is too long (maximum is 6 characters)")
      end

      it '重複したメールアドレスは登録できない' do
        create(:user, email: 'unique@example.com')
        @user.email = 'unique@example.com'
        @user.valid?
        expect(@user.errors[:email]).to include("has already been taken")
      end

      it 'emailが@を含まない場合は登録できない' do
        @user.email = 'testemail.com'
        @user.valid?
        expect(@user.errors[:email]).to include("is invalid")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = 'a' * 129
        @user.password_confirmation = 'a' * 129
        @user.valid?
        expect(@user.errors[:password]).to include("is too long (maximum is 128 characters)")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include("can't be blank")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include("can't be blank")
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("can't be blank")
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("can't be blank")
      end

      it 'birth_dateが空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors[:birth_date]).to include("can't be blank")
      end
    end
  end
end