require 'rails_helper'

RSpec.describe "reservations/new", type: :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      guest: nil,
      host: nil,
      home: nil,
      pets_number: 1,
      amount: "9.99"
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "input[name=?]", "reservation[guest_id]"

      assert_select "input[name=?]", "reservation[host_id]"

      assert_select "input[name=?]", "reservation[home_id]"

      assert_select "input[name=?]", "reservation[pets_number]"

      assert_select "input[name=?]", "reservation[amount]"
    end
  end
end
