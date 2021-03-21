FactoryBot.define do
  factory :episode do
    title { "MyString" }
    plot { "MyText" }
    season_episode_number { 1 }
    season { nil }
  end
end
