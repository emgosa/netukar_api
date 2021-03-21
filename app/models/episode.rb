class Episode < ApplicationRecord
  belongs_to :season
  validates_presence_of :title, :plot, :season_episode_number
end
