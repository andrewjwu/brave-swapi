module Validatable
  extend ActiveSupport::Concern

  private

  def check_url_array
    self.class::URL_ARRAY_ATTRIBUTES.each do |attribute|
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

  def check_numbers
    self.class::NUMBER_ATTRIBUTES.each do |attribute|
      if !is_number?(send(attribute)) && !['n/a', 'unknown'].include?(send(attribute))
        errors.add(attribute, "must be a number")
      end
    end
  end

  def is_number?(value)
    Float(value) rescue nil
  end
end
