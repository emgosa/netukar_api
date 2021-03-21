class Season < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :purchases, as: :purchasable, dependent: :destroy
  validates_presence_of :title, :plot, :number
end
