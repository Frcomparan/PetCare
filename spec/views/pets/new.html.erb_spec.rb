require 'rails_helper'

RSpec.describe "pets/new", type: :view do
  before(:each) do
    assign(:pet, Pet.new(
      name: "MyString",
      breed: "MyString",
      description: "MyString",
      user: nil
    ))
  end

  it "renders new pet form" do
    render

    assert_select "form[action=?][method=?]", pets_path, "post" do

      assert_select "input[name=?]", "pet[name]"

      assert_select "input[name=?]", "pet[breed]"

      assert_select "input[name=?]", "pet[description]"

      assert_select "input[name=?]", "pet[user_id]"
    end
  end
end
