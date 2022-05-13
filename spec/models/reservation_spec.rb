# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before(:each) do
    @user_guest = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                           address: 'Av. Tecnologico #559', email: 'prueba@example', password: '123456')
    @user_host = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                          address: 'Av. Tecnologico #559', email: 'prueba2@example', password: '123456')
    @user_guest.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png',
                                     content_type: 'image/png')
    @user_guest.save!
    @user_host.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png',
                                    content_type: 'image/png')
    @user_host.save!
    @home = Home.create(title: 'Sweet Home', address: 'Av. Niños Heroes', description: 'Perfect home for your dog',
                        price: 560, user_id: @user_host.id)
    @reservation = Reservation.new(guest_id: @user_guest.id, host_id: @user_host.id, home_id: @home.id,
                                   check_in: '12/05/2022', check_out: '16/05/2022', pets_number: 3, amount: 0)
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

  context 'creating reservations with wrong data' do
    before(:each) do
      @reservation_2 = Reservation.new(guest_id: @user_guest.id, host_id: @user_host.id, home_id: @home.id,
                                       check_in: '10/05/2022', check_out: '13/05/2022', pets_number: 3, amount: 0)
    end

    it 'create reservation with the same host and guest' do
      @reservation.host_id = @user_guest_id
      expect(@reservation).not_to be_valid
    end

    it 'create reservation in a reserved date' do
      @reservation.save!
      expect(@reservation_2).not_to be_valid
    end

    it 'create reservation without wrong dates' do
      @reservation_2.check_out = '08/05/2022'
      expect(@reservation_2).not_to be_valid
    end
  end
end
