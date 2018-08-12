require 'test_helper'

class PlanetTest < ActiveSupport::TestCase
  include SwapiTest

  @url_array_attributes = [:films, :residents]
  @url_attributes = [:url]
  @number_attributes = [:population]

  setup do
    @planet = @object = planets(:tatooine)
  end

  self.test_number_attributes
  self.test_url_attributes
  self.test_url_array_attributes
end
