class Schedule < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates_presence_of :title
end
