class Home < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :reservations
  has_many_attached :photos

  validates :title, :address, :description, :price, presence: true
end
