class Home < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :reservations
  has_many_attached :photos

  validates :title, :address, :description, :price, presence: true

  scope :filter_by_price_lower, -> { order :price }
  scope :filter_by_price_higher, -> { order price: :desc }
  scope :filter_by_score, -> { order score: :desc }
  scope :filter_by_date, -> { order created_at: :desc }

  def self.search_filter(filtering_param)
    results = self.where(nil)
    results = results.public_send("filter_by_#{filtering_param}")
    results
  end
end
