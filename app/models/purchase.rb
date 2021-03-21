class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchasable, polymorphic: true, optional: true
  validates_presence_of :quality, :price, :purchasable_id, :purchasable_type, :user_id, :begin_at, :end_at
  validate :available_for_purchase, on: :create

  scope :alive, -> { where("begin_at < :time and end_at > :time", time: DateTime.now) }

  def available_for_purchase
    return if user.nil?
    return unless user.purchases.alive.find_by(user_id: self.user_id, purchasable_id: self.purchasable_id, purchasable_type: self.purchasable_type)
    errors.add(:base, "The #{self.purchasable_type} is already in your library.")
  end
end