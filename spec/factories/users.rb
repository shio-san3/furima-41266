FactoryBot.define do
  factory :user do
    name { "TestUser" }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { password }
    last_name { "山田" }
    first_name { "太郎" }
    last_name_kana { "ヤマダ" }
    first_name_kana { "タロウ" }
    birth_date { "1990-01-01" } # `birthday` ではなく `birth_date` が正しいと仮定
  end
end