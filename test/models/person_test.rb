require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @person = people(:luke)
  end

  test "should not save person without name" do
    @person.name = nil
    assert_not @person.save
  end

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

  [:height, :mass].each do |attribute|
    test "should not save person with invalid #{attribute} values" do
      invalid_values = ['one', nil]
      invalid_values.each do |val|
        @person[attribute] = nil
        assert_not @person.save
      end
    end

    test "should save person with valid #{attribute} values" do
      valid_values = %w(177 23.0 0)
      valid_values.each do |val|
        @person[attribute] = val
        assert @person.save
      end
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

  [:homeworld, :url].each do |attribute|
    test "should not save person with invalid #{attribute} values" do
      invalid_values = %w(earth 123 1.0)
      invalid_values.each do |val|
        @person[attribute] = val
        assert_not @person.save
      end
    end

    test "should person with valid #{attribute} value" do
      @person[attribute] = "https://swapi.co/api/planets/41/"
      assert @person.save
    end
  end

  [:films, :species, :starships, :vehicles].each do |attribute|
    test "person's #{attribute} defaults to an empty array" do
      person = Person.new
      assert_empty person.send(attribute)
    end

    test "should not save person with invalid #{attribute}" do
      invalid_values = %w(swapi.co abc 123 https://swapi.co/api/planets/28/)
      @person[attribute] = invalid_values
      assert_not @person.save
    end

    test "should save person with valid #{attribute}" do
      valid_values = %w(https://swapi.co/api/planets/28/
                        https://swapi.co/api/people/1/)
      @person[attribute] = valid_values
      assert @person.save
    end
  end

  [:created, :edited].each do |attribute|
    test "should not save person with invalid #{attribute} values" do
      invalid_values = ['2015-04-17T06:57:38.061346Z.bad', '12:00PM', nil]
      invalid_values.each do |val|
        @person[attribute] = val
        assert_not @person.save
      end
    end

    test "should save person with valid #{attribute} values" do
      @person[attribute] = "2015-04-17T06:57:38.061346Z"
      assert @person.save
    end
  end

  test "should not save person if swapi_id is taken" do
    duped_person = @person.dup
    assert_not duped_person.save
  end

  test "should not save person without swapi_id" do
    @person.swapi_id = nil
    assert_not @person.save
  end
end
