# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birth_date         | date   | null: false               |

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

## products テーブル

| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| name          | string      | null: false                    |
| price         | decimal     | null: false                    |
| description   | text        | null: false                    |
| status        | string      | null: false                    |
| size          | string      | null: false                    |
| user_id       | references  | null: false, foreign_key: true |

  belongs_to :user
  has_many :orders, dependent: :destroy

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| order_id    | string     | null: false,                   |
| product_id  | references | null: false, foreign_key: true |
| user_id     | references | null: false, foreign_key: true |
| quantity    | integer    | null: false,                   |
| total_price | decimal    | null: false,                   |
| order_date  | date       | null: false,                   |

  belongs_to :user
  belongs_to :product