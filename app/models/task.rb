class Task < ApplicationRecord
  belongs_to :schedule
  validates :date, presence: true
end
