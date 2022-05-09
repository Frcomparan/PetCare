require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      guest: nil,
      host: nil,
      home: nil,
      pets_number: 1,
      amount: "9.99"
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input[name=?]", "reservation[guest_id]"

      assert_select "input[name=?]", "reservation[host_id]"

      assert_select "input[name=?]", "reservation[home_id]"

      assert_select "input[name=?]", "reservation[pets_number]"

      assert_select "input[name=?]", "reservation[amount]"
    end
  end
end
