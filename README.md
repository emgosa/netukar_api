# README

* Ruby version  
  3.0.0

* Rails version  
  6.1.3

* Configuration  
  git clone https://github.com/emgosa/netukar_api.git
  bundle install

* Database creation  
  rails db:create  
  rails db:migrate

* Database initialization  
  rake fill:db

* How to run the test suite  
  bundle exec rspec

* Services (job queues, cache servers, search engines, etc.)  
  Cache and Job queues with Redis and Sidekiq for Endpoint 2

* Deployment instructions  
  redis-server  
  bundle exec sidekiq  
  rails s  

* Endpoints  
    1. localhost:3000/movies_ordered_by_created_at
    2. localhost:3000/season_with_episodes_ordered (stored in cache)
    3. localhost:3000/movies_seasons_ordered_by_created_at
    4. localhost:3000/users/1/purchases?price=2.99&quality=HD&purchasable_id=1&purchasable_type=Movie&begin_at=2021-03-21 23:00:00&end_at=2021-03-23 23:00:00
       *if already exist and its alive you will get an error
       localhost:3000/movies?title=Title&plot=Plot (get id of answer and replace in previous the value of purchasable_id)
    5. localhost:3000/users/1/library
