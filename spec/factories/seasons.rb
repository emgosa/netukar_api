FactoryBot.define do
  factory :season do
    title { Faker::Lorem.word }
    plot { Faker::Lorem.sentences(number: 1) }
    sequence(:number) {|n| "#{n}" }
    after :create do |season|
      create_list :episode, 5, season: season
    end
  end
end