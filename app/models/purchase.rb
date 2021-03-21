class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchasable, polymorphic: true, optional: true
  validates_presence_of :quality, :price, :purchasable_id, :purchasable_type, :user_id, :begin_at, :end_at
  validates :user_id, uniqueness: {scope: [:purchasable_id, :purchasable_type]}

  scope :alive, -> { where("begin_at < :time and end_at > :time", time: DateTime.now) }
end
