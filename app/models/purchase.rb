class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchasable, polymorphic: true, optional: true
  validates_presence_of :quality, :price, :purchasable_id, :purchasable_type, :user_id, :begin_at, :end_at
  validates :user_id, uniqueness: {scope: [:user_id, :purchasable_id, :purchasable_type]}, unless: :already_available

  def alive
    begin_at < DateTime.now && end_at > DateTime.now
  end

  def already_available
    !Purchase.where(user_id: self.user_id, purchasable_type: self.purchasable_type, purchasable_id: self.purchasable_id).last.try(:alive)
  end

end
