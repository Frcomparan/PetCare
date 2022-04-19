require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      name: "MyString",
      gender: "MyString",
      phone: "MyString",
      address: "MyString",
      role: 1
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[gender]"

      assert_select "input[name=?]", "user[phone]"

      assert_select "input[name=?]", "user[address]"

      assert_select "input[name=?]", "user[role]"
    end
  end
end
