class Movie < ApplicationRecord
  has_many :reserves, class_name: 'Reserve', foreign_key: 'movie_id'
  validates_presence_of :name, :url_image, :start_date, :end_date
  validates_format_of :url_image, with: URI::regexp(%w(http https)), message: 'no tiene una URL válida'
  validate :validate_url

  def self.search_by_dates(start_date, end_date)
    start_date = Date.today if start_date.blank?
    end_date = start_date if end_date.blank?
    where('start_date >= ? AND end_date >= ?', start_date.to_date, end_date.to_date)
  end

  def valid_reservate_date?(date)
    return false if date.blank?

    (start_date <= date.to_date && end_date >= date.to_date)
  end

  def validate_url
    require 'net/http'
    if url_image.present?
      begin
        source = URI.parse(url_image)
        resp = Net::HTTP.get_response(source)
        errors.add(:url_image, 'es inválida') if resp.code != '200'
      rescue URI::InvalidURIError
        errors.add(:url_image, 'es inválida')
      rescue SocketError
        errors.add(:url_image, 'es inválida')
      end
    end
  end

end
