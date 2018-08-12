class Person < ApplicationRecord
  include Validatable

  VALID_BIRTH_YEAR_REGEX = /\A(unknown|.*BBY|.*ABY)\z/

  NUMBER_ATTRIBUTES = [:mass, :height]
  URL_ARRAY_ATTRIBUTES = [:films, :species, :starships, :vehicles]

  validates :name, presence: true
  validates :birth_year, presence: true,
              format: { with: VALID_BIRTH_YEAR_REGEX, message: 'is invalid' }
  validates :gender, inclusion: { in: %w(male female unknown n/a),
                                     message: 'is invalid' }
  validates :skin_color, presence: true
  validates :homeworld,
              format: { with: SWAPI_URL_REGEX, message: 'is invalid' }
  validates :url,
              format: { with: SWAPI_URL_REGEX, message: 'is invalid' }
  validates :swapi_id, presence: true, uniqueness: true

  validate :check_numbers
  validate :check_url_array
  validate :check_iso_8601

  def to_h
    {
      name: name,
      height: height,
      mass: mass,
      hair_color: hair_color,
      skin_color: skin_color,
      eye_color: eye_color,
      birth_year: birth_year,
      gender: gender,
      homeworld: homeworld,
      films: films,
      species: species,
      vehicles: vehicles,
      starships: starships,
      created: created,
      edited: edited,
      url: url
    }
  end
end
