class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pets
  has_one :home
  has_many :guest_reservations, class_name: 'Reservation', foreign_key: 'guest_id'
  has_many :host_reservations, class_name: 'Reservation', foreign_key: 'host_id'
  has_many :guest_reviews, class_name: 'Review', foreign_key: 'guest_id'
  has_one_attached :profile_photo

  validates :name, :birthdate, :address, presence: true
  validates :phone, length: { is: 10 }
  validate :validate_profile_photo 
  
  private 
  def validate_profile_photo 
    unless profile_photo and profile_photo.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/ 
      errors.add(:profile_photo, "Not a valid image") 
    end 
  end
end
