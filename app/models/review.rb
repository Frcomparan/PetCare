class Review < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :home

  validates :score, :comment, presence: true
  validates_numericality_of :score, in: 0..100

  validate :can_comment?
  after_save :update_score

  def can_comment?
    errors.add('No tiene ningun comentario pendiente') unless Review.left_comment?(home, guest.id)
  end

  def update_score
    Home.update_score(home)
  end

  def self.left_comment?(home, user)
    reviews = Review.all.where(home_id: home)
    reservations = Reservation.all.where('home_id = ? and status = 3 and guest_id = ?', home, user)
    return reviews.size < reservations.size
  end
end
