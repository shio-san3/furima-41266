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

  has_many :products
  has_many :orders

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
  has_many :orders

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| product_id  | references | null: false, foreign_key: true |
| user_id     | references | null: false, foreign_key: true |
| total_price | decimal    | null: false,                   |
| order_date  | date       | null: false,                   |

  belongs_to :user
  belongs_to :product
  has_one :shipping_address

  ## shipping_addresses テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| order_id    | references | null: false,                   |
| postal_code | string     | null: false, foreign_key: true |
| prefecture  | string     | null: false, foreign_key: true |
| city        | string     | null: false,                   |
| address     | string     | null: false,                   |
| building    | string     | null: false,                   |
| phone       | string     | null: false,                   |

  belongs_to :order