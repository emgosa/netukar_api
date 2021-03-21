class Season < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :episodes_ordered_by_season_number, -> { order('season_episode_number DESC') }, class_name: 'Episode'
  has_many :purchases, as: :purchasable, dependent: :destroy
  validates_presence_of :title, :plot, :number
  after_save :create_json_cache

  scope :ordered_by_created_at, -> {order(created_at: :desc)}

  scope :alive_by_user, -> (user_id) {
    select('seasons.*, purchases.end_at AS end_at')
      .joins('JOIN purchases ON purchases.purchasable_id = seasons.id AND purchases.purchasable_type ="Season"')
      .where("purchases.user_id = #{user_id} AND purchases.begin_at < :time and purchases.end_at > :time", time: DateTime.now)
      .order("purchases.end_at DESC")
  }

  def self.cache_key(seasons)
    {
      serializer: 'seasons',
      stat_record: seasons.maximum(:updated_at)
    }
  end

  private

  def create_json_cache
    CreatePostsJsonCacheJob.perform_now
  end
end
