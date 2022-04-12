require 'rails_helper'

RSpec.describe "homes/index", type: :view do
  before(:each) do
    assign(:homes, [
      Home.create!(
        title: "Title",
        address: "Address",
        description: "Description",
        price: "9.99",
        score: "9.99",
        user: nil
      ),
      Home.create!(
        title: "Title",
        address: "Address",
        description: "Description",
        price: "9.99",
        score: "9.99",
        user: nil
      )
    ])
  end

  it "renders a list of homes" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
