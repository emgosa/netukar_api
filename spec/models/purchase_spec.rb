require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let!(:user) { create(:user_purchases) }
  it { should validate_presence_of(:quality) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:purchasable_id) }
  it { should validate_presence_of(:purchasable_type) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:begin_at) }
  it { should validate_presence_of(:end_at) }
  it { should belong_to(:user) }
end
