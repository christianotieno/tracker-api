require 'rails_helper'

# Test suite for the Schedule model
RSpec.describe Schedule, type: :model do
  # Association test
  # ensure Schedule model has a 1:m relationship with the Task model
  it { should have_many(:tasks).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end