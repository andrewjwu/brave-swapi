module SwapiTest
  extend ActiveSupport::Concern

  included do

    test "should not save object without name" do
      @object.name = nil
      assert_not @object.save
    end

    def self.test_number_attributes
      @number_attributes.each do |attribute|
        test "should not save object with invalid #{attribute} values" do
          invalid_values = ['one', nil]
          invalid_values.each do |val|
            @object[attribute] = nil
            assert_not @object.save
          end
        end

        test "should save object with valid #{attribute} values" do
          valid_values = %w(177 23.0 0)
          valid_values.each do |val|
            @object[attribute] = val
            assert @object.save
          end
        end
      end
    end

    def self.test_url_attributes
      @url_attributes.each do |attribute|
        test "should not save object with invalid #{attribute} values" do
          invalid_values = %w(earth 123 1.0)
          invalid_values.each do |val|
            @object[attribute] = val
            assert_not @object.save
          end
        end

        test "should object with valid #{attribute} value" do
          @object[attribute] = "https://swapi.co/api/planets/41/"
          assert @object.save
        end
      end
    end

    def self.test_url_array_attributes
      @url_array_attributes.each do |attribute|
        test "object's #{attribute} defaults to an empty array" do
          object = @object.class.new
          assert_empty object.send(attribute)
        end

        test "should not save object with invalid #{attribute}" do
          invalid_values = %w(swapi.co abc 123 https://swapi.co/api/planets/28/)
          @object[attribute] = invalid_values
          assert_not @object.save
        end

        test "should save object with valid #{attribute}" do
          valid_values = %w(https://swapi.co/api/planets/28/
                            https://swapi.co/api/people/1/)
          @object[attribute] = valid_values
          assert @object.save
        end
      end
    end

    [:created, :edited].each do |attribute|
      test "should not save object with invalid #{attribute} values" do
        invalid_values = ['2015-04-17T06:57:38.061346Z.bad', '12:00PM', nil]
        invalid_values.each do |val|
          @object[attribute] = val
          assert_not @object.save
        end
      end

      test "should save object with valid #{attribute} values" do
        @object[attribute] = "2015-04-17T06:57:38.061346Z"
        assert @object.save
      end
    end

    test "should not save object if swapi_id is taken" do
      duped_object = @object.dup
      assert_not duped_object.save
    end

    test "should not save object without swapi_id" do
      @object.swapi_id = nil
      assert_not @object.save
    end

  end
end
