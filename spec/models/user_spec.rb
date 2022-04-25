# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027',
                     address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
  end

  it 'create user with valid data' do
    expect(@user).to be_valid
  end

  context 'creating users with missing data' do
    it 'create user without name' do
      @user.name = nil
      expect(@user).not_to be_valid
    end

    it 'create user without birthdate' do
      @user.birthdate = nil
      expect(@user).not_to be_valid
    end

    it 'create user without address' do
      @user.address = nil
      expect(@user).not_to be_valid
    end

    it 'create user without phone' do
      @user.phone = nil
      expect(@user).not_to be_valid
    end

    it 'create user without other data' do
      @user.gender = nil
      expect(@user).to be_valid
    end
  end

  context 'having wrong values' do
    it "validates User's phone with the right length" do
      @user.phone = '3121303990'
      expect(@user).to be_valid
    end

    it "validates User's phone with the right length" do
      @user.phone = '3121909'
      expect(@user).not_to be_valid
    end
  end
end
