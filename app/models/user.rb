class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :movies, through: :purchases, source: :purchasable, source_type: :Movie
  has_many :seasons, through: :purchases, source: :purchasable, source_type: :Season
  validates_presence_of :email
end
