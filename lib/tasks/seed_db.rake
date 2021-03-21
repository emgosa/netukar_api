namespace :fill do
  desc "Clean db and fill it"
  task :db => :environment do

    include FactoryBot

    Rake::Task['db:reset'].invoke

    3.times do
      FactoryBot.create_list(:user_purchases, 100)
      sleep 1
    end
  end
end