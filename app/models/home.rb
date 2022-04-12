class Home < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :reservations
end
