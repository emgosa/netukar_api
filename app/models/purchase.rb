class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchasable, polymorphic: true, optional: true
  validates_presence_of :quality, :price, :purchasable_id, :purchasable_type, :user_id, :begin_at, :end_at
  validates :purchasable_id, :purchasable_type, uniqueness: {scope: [:purchasable_id, :purchasable_type]}
end
