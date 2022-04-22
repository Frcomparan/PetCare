require 'rails_helper'

RSpec.describe "pets/new", type: :view do
  before(:each) do
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 0,
      address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    
    pet = Pet.new(name: 'Firulais', breed: 'Pug', description: 'It is a calm dog who loves to sleep all day ', user: @user)
    pet.photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    @pet2 = assign(:pet, pet)
  end

  it "renders new pet form" do
    render

    assert_select "form[action=?][method=?]", pets_path, "post" do

      assert_select "input[name=?]", "pet[name]"

      assert_select "input[name=?]", "pet[breed]"

      assert_select "input[name=?]", "pet[description]"
    end
  end
end
