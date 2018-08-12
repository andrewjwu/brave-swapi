class Person < ApplicationRecord
  VALID_BIRTH_YEAR_REGEX = /\A(unknown|.*BBY|.*ABY)\z/

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

  private

  def check_numbers
    [:mass, :height].each do |attribute|
      if !is_number?(send(attribute))
        errors.add(attribute, "must be a number")
      end
    end
  end

  def check_url_array
    [:films, :species, :starships, :vehicles].each do |attribute|
      if send(attribute).any?
        checked_values = send(attribute).map do |val|
          SWAPI_URL_REGEX.match(val)
        end

        if checked_values.include?(nil)
          errors.add(attribute, "contains an invalid value")
        end
      end
    end
  end

  def check_iso_8601
    [:created, :edited].each do |attribute|
      if !is_iso_8601?(send(attribute))
        errors.add(attribute, 'must be in ISO 8601 format')
      end
    end
  end

  def is_iso_8601?(value)
    Time.iso8601(value) rescue nil
  end

  def is_number?(value)
    Float(value) rescue nil
  end
end
