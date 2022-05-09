# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :host, class_name: 'User'
  belongs_to :home

  validates :check_in, :check_out, :pets_number, presence: true
  validate :valid_dates?
  validate :same_user?
  validate :is_available?

  def is_available?
    taken = Reservation.where('check_in <= ? and check_out >= ?', check_out, check_in)
    errors.add('Hay una reservación en la fecha seleccionada') unless taken.size.zero?
  end

  def same_user?
    errors.add('No puedes reservar tu propia casa') if guest_id == host_id
  end

  def valid_dates?
    correct_date = check_in < check_out
    errors.add('Tu fecha de salida no puede ser menor a la fecha de entrada') unless correct_date
  end
end
