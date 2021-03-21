require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:plot) }

  it { should have_many(:purchases).dependent(:destroy) }
end
