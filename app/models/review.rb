class Review < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :home

  validates :score, :comment, presence: true
  validates_numericality_of :score, in: 0..100

  validate :can_review?
  after_save :update_score

  def can_review?
    errors.add('No tiene ningun comentario pendiente') unless Review.left_review?(home, guest.id)
  end

  def update_score
    Home.update_score(home)
  end

  def self.left_review?(home, user)
    reviews = Review.where(home_id: home)
    reservations = Reservation.all.where('home_id = ? and status = 3 and guest_id = ?', home, user)
    return reviews.size < reservations.size
  end

  def self.total_reviews(home)
    return Review.where(home_id: home).size
  end
end
