require 'rails_helper'

RSpec.describe "homes/show", type: :view do
  before(:each) do
    @home = assign(:home, Home.create!(
      title: "Title",
      address: "Address",
      description: "Description",
      price: "9.99",
      score: "9.99",
      user: nil
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
