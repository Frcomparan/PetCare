require 'rails_helper'

RSpec.describe Pet, type: :model do
  before(:each) do 
    @user = User.create(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', address: 'Av. Tecnologico #559')
    @pet = Pet.new(name: 'Firulais', breed: 'Pug', description: 'It is a calm dog who loves to sleep all day ', user_id: @user.id)
  end

  it 'create pet with valid data' do
    puts @user.id
    expect(@pet).to be_valid
  end

  context 'creating pets with missing data' do
    it 'create pet without name' do
      @pet.name = nil
      expect(@pet).not_to be_valid
    end

    it 'create pet without breed' do
      @pet.breed = nil
      expect(@pet).not_to be_valid
    end

    it 'create pet without description' do
      @pet.description = nil
      expect(@pet).not_to be_valid
    end
  end
end
