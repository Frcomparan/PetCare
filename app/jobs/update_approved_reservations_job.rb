class UpdateApprovedReservationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    reservations = Reservation.where('status = ? and check_out < ?', 1, Date.today)
    reservations.each { |reservation| reservation.update(status: 3) }
  end
end
