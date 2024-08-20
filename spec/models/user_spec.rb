require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context '正常系' do
    it '全ての項目が正しく入力されていれば登録できる' do
      expect(user).to be_valid
    end
  end

  context '異常系' do
    before do
      @user = build(:user)
    end

    it 'nameが空では登録できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it 'メールアドレスが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it '重複したメールアドレスは登録できない' do
      existing_user = create(:user)
      @user.email = existing_user.email
      @user.valid?
      expect(@user.errors[:email]).to include("has already been taken")
    end

    it 'メールアドレスに@を含まない場合は登録できない' do
      @user.email = 'testemail.com'
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'パスワードが6文字未満では登録できない' do
      @user.password = 'abc12'
      @user.password_confirmation = 'abc12'
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors[:password]).to include("must include both letters and numbers")
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors[:password]).to include("must include both letters and numbers")
    end

    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'ａｂｃｄｅｆ１２３'
      @user.password_confirmation = 'ａｂｃｄｅｆ１２３'
      @user.valid?
      expect(@user.errors[:password]).to include("must include both letters and numbers")
    end

    it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
      @user.password_confirmation = 'different'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it '姓（全角）が空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it '姓（全角）に半角文字が含まれていると登録できない' do
      @user.last_name = 'Yamada'
      @user.valid?
      expect(@user.errors[:last_name]).to include("must be full-width characters (kanji, hiragana, katakana)")
    end

    it '名（全角）が空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it '名（全角）に半角文字が含まれていると登録できない' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors[:first_name]).to include("must be full-width characters (kanji, hiragana, katakana)")
    end

    it '姓（カナ）が空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("can't be blank")
    end

    it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("must be full-width katakana characters")
    end

    it '名（カナ）が空だと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("can't be blank")
    end

    it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("must be full-width katakana characters")
    end

    it '生年月日が空だと登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors[:birth_date]).to include("can't be blank")
    end
  end
end