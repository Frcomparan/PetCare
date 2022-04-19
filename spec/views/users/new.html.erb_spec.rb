require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      name: "MyString",
      gender: "MyString",
      phone: "MyString",
      address: "MyString",
      role: 1
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[gender]"

      assert_select "input[name=?]", "user[phone]"

      assert_select "input[name=?]", "user[address]"

      assert_select "input[name=?]", "user[role]"
    end
  end
end
