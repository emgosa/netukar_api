class Movie < ApplicationRecord
  has_many :purchases, as: :purchasable, dependent: :destroy
  validates_presence_of :title, :plot
end
