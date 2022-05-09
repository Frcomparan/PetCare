require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        guest: nil,
        host: nil,
        home: nil,
        pets_number: 2,
        amount: "9.99"
      ),
      Reservation.create!(
        guest: nil,
        host: nil,
        home: nil,
        pets_number: 2,
        amount: "9.99"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
