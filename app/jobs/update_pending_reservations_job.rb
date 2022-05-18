class UpdatePendingReservationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    reservations = Reservation.where('status = ? and check_in < ?', 0, Date.today)
    reservations.each { |reservation| reservation.update(status: 2) }
  end
end
