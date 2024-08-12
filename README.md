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

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| name               | string      | null: false                    |
| price              | integer     | null: false                    |
| description        | text        | null: false                    |
| condition_id       | integer     | null: false                    |
| user               | references  | null: false, foreign_key: true |
| shipping_area_id   | integer     | null: false                    |
| shipping_price_id  | integer     | null: false                    |
| shipping_date_id   | integer     | null: false                    |
| shipping_method_id | integer     | null: false             |

  belongs_to :user
  has_one :order

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| product     | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

  belongs_to :user
  belongs_to :product
  has_one :shipping_address

  ## shipping_addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| order            | references | null: false, foreign_key: true |
| postal_code      | string     | null: false                    |
| shipping_area_id | integer    | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| building         | string     |                                |
| phone            | string     | null: false                    |

  belongs_to :order