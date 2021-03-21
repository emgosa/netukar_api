FactoryBot.define do
  factory :episode do
    title { Faker::Lorem.word }
    plot { Faker::Lorem.sentences(number: 1) }
    sequence(:season_episode_number) { |n| "#{n}" }
    season_id { nil }
  end
end