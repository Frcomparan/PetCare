require 'rails_helper'

RSpec.describe "homes/edit", type: :view do
  before(:each) do
    @home = assign(:home, Home.create!(
      title: "MyString",
      address: "MyString",
      description: "MyString",
      price: "9.99",
      score: "9.99",
      user: nil
    ))
  end

  it "renders the edit home form" do
    render

    assert_select "form[action=?][method=?]", home_path(@home), "post" do

      assert_select "input[name=?]", "home[title]"

      assert_select "input[name=?]", "home[address]"

      assert_select "input[name=?]", "home[description]"

      assert_select "input[name=?]", "home[price]"

      assert_select "input[name=?]", "home[score]"

      assert_select "input[name=?]", "home[user_id]"
    end
  end
end
