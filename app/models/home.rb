class Home < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :reservations

  validates :title, :address, :description, :price, presence: true
end
