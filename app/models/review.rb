class Review < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :home

  validates :score, :comment, presence: true
  validates_numericality_of :score, in: 0..100
end
