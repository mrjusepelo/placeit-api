class Movie < ApplicationRecord
  has_many :reserves, class_name: 'Reserve', foreign_key: 'movie_id'
  validates_presence_of :name, :start_date, :end_date

  def self.search_by_dates(start_date, end_date)
    start_date = Date.today if start_date.blank?
    end_date = start_date if end_date.blank?
    where('start_date <= ? AND end_date >= ?', start_date.to_date, end_date.to_date)
  end

  def valid_reservate_date?(date)
    return false if date.blank?

    (start_date <= date.to_date && end_date >= date.to_date)
  end

end
