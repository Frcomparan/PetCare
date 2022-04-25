require 'rails_helper'

RSpec.describe "homes/edit", type: :view do
  before(:each) do
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 0,
      address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    @home = assign(:home, Home.create!(
      title: "MyString",
      address: "MyString",
      description: "MyString",
      price: "9.99",
      score: "9.99",
      user: @user
    ))
  end

  it "renders the edit home form" do
    render

    assert_select "form[action=?][method=?]", home_path(@home), "post" do

      assert_select "input[name=?]", "home[title]"

      assert_select "input[name=?]", "home[address]"

      assert_select "input[name=?]", "home[description]"

      assert_select "input[name=?]", "home[price]"
    end
  end
end
