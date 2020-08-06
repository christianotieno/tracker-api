class Task < ApplicationRecord
  # model association
  belongs_to :schedule

  # validation
  validates_presence_of :name
end
