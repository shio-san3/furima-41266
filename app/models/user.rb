class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # ニックネームのバリデーション
  validates :name, presence: true
  # パスワードのバリデーション
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "must include both letters and numbers" }
  # お名前(全角)のバリデーション
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be full-width characters (kanji, hiragana, katakana)" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be full-width characters (kanji, hiragana, katakana)" }
  # お名前カナ(全角)のバリデーション
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
  # 生年月日のバリデーション
  validates :birth_date, presence: true
  # パスワード確認用の仮想属性
  attr_accessor :password_confirmation
  # パスワードとパスワード確認の一致確認
  validate :passwords_must_match
  # 重複するエラーメッセージを除去
  after_validation :remove_duplicate_errors

  private

  # パスワードとパスワード確認が一致しているかのチェック
  def passwords_must_match
    if password != password_confirmation
      errors.add(:password_confirmation, "does not match password")
    end
  end
  def remove_duplicate_errors
    unique_errors = errors.uniq do |error|
      [error.attribute, error.type]
    end
  end
end