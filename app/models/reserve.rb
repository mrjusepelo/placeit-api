class Reserve < ApplicationRecord
  belongs_to :movie
  validates_presence_of :cellphone, :email, :name, :number_document, :reserve_date, :seat
  validates_uniqueness_of :movie_id, scope: %i[reserve_date number_document], :message => '%{value} ya tiene una reserva con el documento y fecha ingresados'
  validates_uniqueness_of :seat, scope: %i[reserve_date movie_id], :message => '%{value} ya tiene una reserva para esta silla'
  validate :reservations


  def self.search_by_dates(start_date, end_date)
    start_date = Date.today if start_date.blank?
    end_date = start_date if end_date.blank?
    where('reserve_date >= ? AND reserve_date <= ?', start_date.to_date, end_date.to_date)
  end


  private

  def reservations
    if Reserve.where(movie_id: movie_id, reserve_date: reserve_date).size >= 10
      errors.add(:base, 'Esta película ya se encuentra reservada completamente para la fecha ingresada')
    elsif movie.valid_reservate_date?(reserve_date) == false
      errors.add(:reserve_date, 'La película no tiene disponibilidad para la fecha ingresada')
    end
  end

end
