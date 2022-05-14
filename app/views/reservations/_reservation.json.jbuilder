json.extract! reservation, :id, :guest_id, :host_id, :home_id, :check_in, :check_out, :pets_number, :amount, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
