class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :host, class_name: 'User'
  belongs_to :home
end
