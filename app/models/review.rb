class Review < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :home
  belongs_to :reservation

  validates :score, :comment, presence: true
  validates_numericality_of :score, in: 0..100

  validate :can_review?
  validate :valid_reservation?
  after_save :update_score
  after_create :create_notifications

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

  def valid_reservation?
    errors.add('La reservación aun no ha finalizado') unless reservation.finished? 
  end

  def self.total_reviews(home)
    return Review.where(home_id: home).size
  end

  def create_notifications
    Notification.create(recipient: reservation.host, notifiable: self)
  end
end
