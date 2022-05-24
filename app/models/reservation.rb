# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :host, class_name: 'User'
  belongs_to :home
  has_one :review

  validates :check_in, :check_out, :pets_number, presence: true
  validate :same_user?
  validate :valid_dates?
  validate :available?
  validate :set_amount
  after_create :create_notifications
  after_save :create_review_notification

  scope :valid_update, lambda { |check_out, check_in, id, home_id|
                         where('check_in <= ? and check_out >= ? and id <> ? and home_id = ? and status <> 2', check_out, check_in, id, home_id)
                       }
  scope :valid_create, lambda { |check_out, check_in, home_id|
                         where('check_in <= ? and check_out >= ? and home_id = ? and status <> 2', check_out, check_in, home_id)
                       }

  scope :reserved_dates, -> { where('status <> 2') }

  enum status: { pending: 0, aproved: 1, canceled: 2, finished: 3 }

  def available?
    taken = if id
              Reservation.valid_update(check_out, check_in, id, home_id)
            else
              Reservation.valid_create(check_out, check_in, home_id)
            end
    errors.add('Hay una reservación en la fecha seleccionada') unless taken.size.zero?
  end

  def same_user?
    errors.add('No puedes reservar tu propia casa') if guest_id == host_id
  end

  def valid_dates?
    correct_date = check_in < check_out
    errors.add('Tu fecha de salida no puede ser menor a la fecha de entrada') unless correct_date
  end

  def set_amount
    self.amount = (check_out - check_in).to_i * home.price
  end

  def self.update_pending_reservation
    reservations = Reservation.where('status = ? and check_in < ?', 0, Date.today)
    reservations.each { |reservation| reservation.update(status: 2) }
  end

  def self.update_approved_reservation
    reservations = Reservation.where('status = ? and check_out < ?', 1, Date.today)
    reservations.each { |reservation| reservation.update(status: 3) }
  end

  def start_time
    self.check_in
  end

  def end_time
    self.check_out
  end
  
  def create_notifications
    msg = "#{guest.name} necesita un lugar para su mascota del #{check_in.strftime('%d/%m/%Y')} al #{check_out.strftime('%d/%m/%Y')}"
    Notification.create(recipient: host, notifiable: self, text: msg)
  end

  def create_review_notification
    if status == 'finished'
      msg = "Realice un comentario sobre su estadia en '#{home.title}'"
      Notification.create(recipient: guest, notifiable: self, text: msg)
    end
  end

  def translate_status
    options = { pending: 'Pendiente', aproved: 'Aprovado', canceled: 'Cancelado', finished: 'Finalizado' }
    options[self.status.to_sym]
  end
end
