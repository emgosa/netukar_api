FactoryBot.define do
  factory :purchase do
    quality { "MyString" }
    price { 1.5 }
    purchasable_id { 1 }
    purchasable_type { "MyString" }
    begin_at { "2021-03-21 09:50:53" }
    end_at { "2021-03-21 09:50:53" }
    user { nil }
  end
end
