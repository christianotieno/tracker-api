class User < ApplicationRecord
  has_secure_password
  has_many :schedules, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 4 }
  validates :password, length: { minimum: 6 }
end
