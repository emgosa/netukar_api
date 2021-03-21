FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    plot { Faker::Lorem.sentences(number: 1) }
  end
end
