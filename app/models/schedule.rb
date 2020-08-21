class Schedule < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
end
