# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Home, type: :model do
  before(:each) do
    @user = User.create(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                        address: 'Av. Tecnologico #559')
    @home = Home.new(title: 'Sweet Home', address: 'Av. Niños Heroes', description: 'Perfect home for your dog',
                     price: 560, user_id: @user.id)
  end

  it 'create home with valid data' do
    expect(@home).to be_valid
  end

  context 'creating homes with missing data' do
    it 'create home without title' do
      @home.title = nil
      expect(@home).not_to be_valid
    end

    it 'create home without address' do
      @home.address = nil
      expect(@home).not_to be_valid
    end

    it 'create home without description' do
      @home.description = nil
      expect(@home).not_to be_valid
    end

    it 'create home without price' do
      @home.price = nil
      expect(@home).not_to be_valid
    end
  end
end
