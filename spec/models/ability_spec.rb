require 'cancan/matchers'
require 'rails_helper'

RSpec.describe 'Ability' do
  before(:each) do
    # Users creation
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 0,
                     address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    
    @user2 = User.new(name: 'Ernesto Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 1,
      address: 'Av. Tecnologico #559', email:"prueba2@example", password:"123456")
    @user2.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    
    @user3 = User.new(name: 'Aurelio Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 2,
      address: 'Av. Tecnologico #559', email:"prueba3@example", password:"123456")
    @user3.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    
    @user.save!
    @user2.save!
    @user3.save!

    @guest_ability = Ability.new(@user)
    @host_ability = Ability.new(@user2)
    @admin_ability = Ability.new(@user3)
  end
  
  context 'verify guest permissions' do
    it 'a guest can create a pet' do 
      expect(@guest_ability).to be_able_to(:create, Pet.new(user: @user))
    end

    it 'a guest can read, update and destroy his own pets' do
      expect(@guest_ability).to be_able_to([:read, :update, :destroy], Pet.new(user: @user))
    end

    it 'a guest can´t read, update and destroy pets dont belong to him' do
      expect(@guest_ability).not_to be_able_to([:read, :update, :destroy], Pet.new(user: @user2))
    end

    it 'a guest can only read homes' do 
      expect(@guest_ability).to be_able_to(:read, Home.new(user: @user))
      expect(@guest_ability).not_to be_able_to([:create, :update, :destroy], Home.new(user: @user))
    end
  end
  
  context 'verify host permissions' do
    it 'a host can create and read pets' do 
      expect(@host_ability).to be_able_to([:create, :read], Pet.new(user: @user2))
    end

    it 'a host can update and destroy his own pets' do
      expect(@host_ability).to be_able_to([:update, :destroy], Pet.new(user: @user2))
    end

    it 'a host can´t update and destroy pets dont belong to him' do
      expect(@host_ability).not_to be_able_to([:update, :destroy], Pet.new(user: @user))
    end

    it 'a host can create and read homes' do 
      expect(@host_ability).to be_able_to([:create, :read], Home.new(user: @user2))
    end

    it 'a host can update and destroy his own homes' do
      expect(@host_ability).to be_able_to([:update, :destroy], Home.new(user: @user2))
    end

    it 'a host can´t update and destroy homes dont belong to him' do
      expect(@host_ability).not_to be_able_to([:update, :destroy], Home.new(user: @user))
    end
  end

  context 'verify admins permissions' do
    it 'an admin can manege all' do
      expect(@admin_ability).to be_able_to(:manage, :all)
    end
  end

end
