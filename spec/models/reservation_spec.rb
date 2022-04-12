# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before(:each) do
    user_guest = User.create(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                             address: 'Av. Tecnologico #559')
    user_host = User.create(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                            address: 'Av. Tecnologico #559')
    home = Home.create(title: 'Sweet Home', address: 'Av. Niños Heroes', description: 'Perfect home for your dog',
                       price: 560, user_id: user_host.id)
    @reservation = Reservation.new(guest_id: user_guest.id, host_id: user_host.id, home_id: home.id,
                                   check_in: 'Tue, 12 Apr 2022 16:40:04 -0500', check_out: 'Tue, 13 Apr 2022 20:40:04 -0500', pets_number: 3, amount: 0)
  end

  it 'create reservation with valid data' do
    expect(@reservation).to be_valid
  end

  context 'creating reservations with missing data' do
    it 'create reservation without check_in' do
      @reservation.check_in = nil
      expect(@reservation).not_to be_valid
    end

    it 'create reservation without check_out' do
      @reservation.check_out = nil
      expect(@reservation).not_to be_valid
    end

    it 'create reservation without pets_number' do
      @reservation.pets_number = nil
      expect(@reservation).not_to be_valid
    end

    it 'create reservation without unnecessary fields' do
      @reservation.amount = nil
      expect(@reservation).to be_valid
    end
  end
end
