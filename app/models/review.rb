class Review < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :home

  validates :score, :comment, presence: true
end
