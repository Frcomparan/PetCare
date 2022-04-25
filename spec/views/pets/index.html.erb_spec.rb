require 'rails_helper'

RSpec.describe "pets/index", type: :view do
  before(:each) do
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 0,
      address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    @user.save!
    pet = Pet.new(name: 'Firulais', breed: 'Pug', description: 'It is a calm dog who loves to sleep all day ', user: @user)
    pet.photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    pet.save!
    assign(:pets, [pet])
  end

  it "renders a list of pets" do
    render
    assert_select 'p>strong', text: 'Name:'.to_s, count: 1
    assert_select 'p>strong', text: 'Breed:'.to_s, count: 1
    assert_select 'p>strong', text: 'Description:'.to_s, count: 1
    assert_select 'p>strong', text: 'User:'.to_s, count: 1
    assert_select 'p>strong', text: 'Photo:'.to_s, count: 1
  end
end
