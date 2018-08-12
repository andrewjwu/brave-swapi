require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  include SwapiTest

  @url_array_attributes = [:films, :species, :starships, :vehicles]
  @url_attributes = [:homeworld, :url]
  @number_attributes = [:height, :mass]

  setup do
    @person = @object = people(:luke)
  end

  self.test_number_attributes
  self.test_url_attributes
  self.test_url_array_attributes

  test "should not save person with invalid birth year values" do
    invalid_values = ['foobar', 2018, nil]
    invalid_values.each do |val|
      @person.birth_year = val
      assert_not @person.save
    end
  end

  test "should save person with valid birth year values" do
    valid_values = %w(unknown 19BBY 20ABY)
    valid_values.each do |val|
      @person.birth_year = val
      assert @person.save
    end
  end

  test "should not save person with invalid gender values" do
    invalid_gender_values = ['a', 'b', 'c', nil] 
    invalid_gender_values.each do |val|
      @person.gender = val 
      assert_not @person.save
    end
  end

  test "should save person with valid gender values" do
    valid_gender_values = %w(male female unknown n/a)
    valid_gender_values.each do |val|
      @person.gender = val 
      assert @person.save
    end
  end

  [:eye_color, :gender, :hair_color].each do |attribute|
    test "person's #{attribute} defaults to n/a" do
      person = Person.new
      assert_equal 'n/a', person.send(attribute)
    end
  end

  test "should not save person without skin color" do
    @person.skin_color = nil
    assert_not @person.save
  end

end
