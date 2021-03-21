FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    factory :user_purchases do
      after :create do |user|
        create_list :purchase_movie, 3, user: user
        create_list :purchase_season, 3, user: user
      end
    end
  end
end