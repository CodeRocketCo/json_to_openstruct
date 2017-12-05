require 'string_helper'
require 'minitest/autorun'

describe StringHelper do

  describe "when the text is underscored" do
    it "should be with underscores" do
      StringHelper.underscore("CamelText").must_equal "camel_text"
    end
  end

	describe "when the text is normalized" do
		it "'_attributes' is removed" do
			StringHelper.normalize('recipients_attributes').must_equal "recipients"
		end
	end

	describe "when the word is checked if number" do
		it "must return true only when it is" do
			StringHelper.is_i?("078").must_equal true
			StringHelper.is_i?("asd").must_equal false
			StringHelper.is_i?("7a8").must_equal false
		end
	end

end
