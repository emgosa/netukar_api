class CreatePostsJsonCacheJob < ApplicationJob
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'default'

  def perform(*args)
    seasons = Season.includes(:episodes_ordered_by_season_number)
    Rails.cache.fetch(Season.cache_key(seasons)) do
      seasons.to_json(include: :episodes_ordered_by_season_number)
    end
  end
end
