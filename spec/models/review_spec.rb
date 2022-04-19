# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:each) do
    user_guest = User.create(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                             address: 'Av. Tecnologico #559')
    user_guest.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    user_guest.save!
    home = Home.create(title: 'Sweet Home', address: 'Av. Niños Heroes', description: 'Perfect home for your dog',
                       price: 560, user_id: user_guest.id)
    @review = Review.new(guest_id: user_guest.id, home_id: home.id, score: 90, comment: 'Great service')
  end

  it 'create review with valid data' do
    expect(@review).to be_valid
  end

  context 'creating reviews with missing data' do
    it 'create review without score' do
      @review.score = nil
      expect(@review).not_to be_valid
    end

    it 'create review without comment' do
      @review.comment = nil
      expect(@review).not_to be_valid
    end
  end

  it 'create a review with score heiger than 100' do
    @review.score = 101
    expect(@review).not_to be_valid
  end
end
