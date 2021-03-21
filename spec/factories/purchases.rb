FactoryBot.define do
  factory :purchase do
    factory :purchase_movie do
      quality { "HD" }
      price { 2.99 }
      association :purchasable, factory: :season
      begin_at { DateTime.now }
      end_at { DateTime.now + 2.days }
      user_id { nil }
    end
    factory :purchase_season do
      quality { "HD" }
      price { 2.99 }
      association :purchasable, factory: :movie
      begin_at { DateTime.now }
      end_at { DateTime.now + 2.days }
      user_id { nil }
    end
  end
end
