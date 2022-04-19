class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :name, :breed, :description, presence: true
  validate :validate_photo 
  
  private 
  def validate_photo 
    unless photo and photo.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/ 
      errors.add(:photo, "Not a valid image") 
    end 
  end 
end
