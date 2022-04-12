class User < ApplicationRecord
  has_many :pets
  has_one :home
end
