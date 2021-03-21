class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :movies, through: :purchases, source: :purchasable, source_type: :Movie
  has_many :seasons, through: :purchases, source: :purchasable, source_type: :Season
  validates_presence_of :email

  scope :library, -> (user_id) {
    joins("JOIN purchases ON purchases.user_id = #{user_id}")
      .joins("JOIN movies ON movies.id = purchases.purchasable_id AND purchases.purchasable_type = 'Movie'")
      .joins("JOIN seasons ON seasons.id = purchases.purchasable_id AND purchases.purchasable_type = 'Season'")
      .select('movies.title, seasons.title')
      .where("purchases.begin_at < :time and purchases.end_at > :time", time: DateTime.now)
  }
end
