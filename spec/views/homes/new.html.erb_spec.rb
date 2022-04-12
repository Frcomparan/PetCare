require 'rails_helper'

RSpec.describe "homes/new", type: :view do
  before(:each) do
    assign(:home, Home.new(
      title: "MyString",
      address: "MyString",
      description: "MyString",
      price: "9.99",
      score: "9.99",
      user: nil
    ))
  end

  it "renders new home form" do
    render

    assert_select "form[action=?][method=?]", homes_path, "post" do

      assert_select "input[name=?]", "home[title]"

      assert_select "input[name=?]", "home[address]"

      assert_select "input[name=?]", "home[description]"

      assert_select "input[name=?]", "home[price]"

      assert_select "input[name=?]", "home[score]"

      assert_select "input[name=?]", "home[user_id]"
    end
  end
end
