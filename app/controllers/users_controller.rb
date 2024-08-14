class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path # root（topに移動？）にリダイレクト
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # ニックネームのバリデーション
  validates :nickname, presence: true
  # メールアドレスのバリデーション
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must include @" }
   # パスワードのバリデーション
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "must include both letters and numbers" }
  # お名前(全角)のバリデーション
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠]+\z/, message: "must be full-width characters (kanji, hiragana, katakana)" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠]+\z/, message: "must be full-width characters (kanji, hiragana, katakana)" }
  # お名前カナ(全角)のバリデーション
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
  # 生年月日のバリデーション
  validates :birthdate, presence: true
  # パスワード確認用の仮想属性
  attr_accessor :password_confirmation
  # パスワードとパスワード確認の一致確認
  validate :passwords_must_match
  
  private

  # パスワードとパスワード確認が一致しているかのチェック
  def passwords_must_match
    if password != password_confirmation
      errors.add(:password_confirmation, "does not match password")
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
