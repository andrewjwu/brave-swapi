class Planet < ApplicationRecord
  include Validatable

  URL_ARRAY_ATTRIBUTES = [:films, :residents]
  URL_ATTRIBUTES = [:url]
  NUMBER_ATTRIBUTES = [:population]

  validates :name, presence: true
  validates :url, format: { with: SWAPI_URL_REGEX, message: 'is invalid' }
  validates :swapi_id, presence: true, uniqueness: true

  validate :check_numbers
  validate :check_url_array
  validate :check_iso_8601

  # TODO: consider validating diameter, rotation period, orbital period
  #       as numbers although we'd have to allow for 'n/a' and/or 'unknown'
  #       values

  def to_h
    {
      name: name,
      rotation_period: rotation_period,
      orbital_period: orbital_period,
      diameter: diameter,
      climate: climate,
      gravity: gravity,
      terrain: terrain,
      surface_water: surface_water,
      population: population,
      residents: residents,
      films: films,
      created: created,
      edited: edited,
      url: url
    }
  end
end
