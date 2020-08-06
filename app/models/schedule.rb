class Schedule < ApplicationRecord
  # model association
  has_many :tasks, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
