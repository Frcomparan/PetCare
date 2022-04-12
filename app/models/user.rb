class User < ApplicationRecord
  has_many :pets
  has_one :home
  has_many :guest_reservations, class_name: 'Reservation', foreign_key: 'guest_id'
  has_many :host_reservations, class_name: 'Reservation', foreign_key: 'host_id'
  has_many :guest_reviews, class_name: 'Review', foreign_key: 'guest_id'

  validates :name, :birthdate, :address, presence: true
  validates :phone, length: { is: 10 }

end
