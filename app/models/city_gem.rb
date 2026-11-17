require "uri"

class CityGem < ApplicationRecord
  belongs_to :tag
  belongs_to :neighbourhood
  belongs_to :category

  scope :published, -> { where(published: true) }

  validates :published, inclusion: { in: [true, false] }
  validates :title, :location, presence: true, length: { maximum: 160 }
  validates :short_desc, presence: true, length: { maximum: 280 }
  validates :image, length: { maximum: 2048 }
  validate :image_has_http_url, if: -> { image.present? }

  def google_maps_url
    "https://www.google.com/maps/search/?#{URI.encode_www_form(api: 1, query: "#{title}, #{location}")}"
  end

  private

  def image_has_http_url
    uri = URI.parse(image)
    errors.add(:image, "must be an HTTP or HTTPS URL") unless uri.is_a?(URI::HTTP) && uri.host.present? && uri.userinfo.nil?
  rescue URI::InvalidURIError
    errors.add(:image, "must be an HTTP or HTTPS URL")
  end
end
