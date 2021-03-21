class Movie < ApplicationRecord
  has_many :purchases, as: :purchasable, dependent: :destroy
  validates_presence_of :title, :plot

  scope :ordered_by_created_at, -> {order(created_at: :desc)}

  scope :alive_by_user, -> (user_id) {
    select('movies.*, purchases.end_at AS end_at')
      .joins('JOIN purchases ON purchases.purchasable_id = movies.id AND purchases.purchasable_type ="Movie"')
      .where("purchases.user_id = #{user_id} AND purchases.begin_at < :time and purchases.end_at > :time", time: DateTime.now)
      .order("purchases.end_at DESC")
  }
end
