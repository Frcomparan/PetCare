class Pet < ApplicationRecord
  belongs_to :user

  validates :name, :breed, :description, presence: true
end
