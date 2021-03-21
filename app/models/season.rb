class Season < ApplicationRecord
  has_many :episodes, dependent: :destroy
  validates_presence_of :title, :plot, :number
end
