require 'rails_helper'

RSpec.describe "homes/show", type: :view do
  before(:each) do
    @user = User.new(name: 'Marco Polo', gender: 'Male', birthdate: '05/07/2000', phone: '3121358027', role: 0,
      address: 'Av. Tecnologico #559', email:"prueba@example", password:"123456")
    @user.profile_photo.attach(io: File.open('img/logo-bc.png'), filename: 'logo-bc.png', content_type: 'image/png')
    @home = assign(:home, Home.create!(
      title: "Title",
      address: "Address",
      description: "Description",
      price: "9.99",
      score: "9.99",
      user: @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
