class Task < ApplicationRecord
  belongs_to :schedule
  validates :date, presence: true
  validates_presence_of :name
end
