class Reservation < ApplicationRecord
  belongs_to :guest
  belongs_to :host
  belongs_to :publication
end
