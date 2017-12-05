require 'json_to_openstruct'
require 'minitest/autorun'

describe JsonToOpenStruct do
	before do
    class OpenStruct
			include JsonToOpenStruct
		end

		@json = '{"title":"title 1","coll": [{"SubTitle":"Subtitle 1"},{"sub_title":"Subtitle 2"}]}'
		@json2 = '{"title":"title 1","coll": [{"sub_title":"Subtitle 1"},{"sub_title":"Subtitle 2"}]}'
		@hash = { name: "Name 1", data: { sub_title: "Subtitle 3" }}
  end

  describe "when the json is parsed" do
    it "OpenStruct instance attributes must have values loaded from json" do
      struct = OpenStruct.parse_json(@json)
			struct.title.must_equal "title 1"
			struct.coll[0].sub_title.must_equal "Subtitle 1"
			struct.coll[1].sub_title.must_equal "Subtitle 2"
    end
  end

	describe "when the hash is parsed" do
		it "OpenStruct instance must have values loaded from hash" do
			struct = OpenStruct.parse_hash(@hash)
			struct.name.must_equal "Name 1"
			struct.data.sub_title.must_equal "Subtitle 3"
		end
	end

	describe "when the OpenStruct instance is converted to hash" do
		it "the hash must have the values from OpenStruct instance" do
			struct = OpenStruct.parse_hash(@hash)
			parsed_hash = struct.to_hash
			parsed_hash.hash.must_equal @hash.hash
		end
	end

	describe "when the OpenStruct instance is converted to json" do
		it "the json must have the values from OpenStruct instance" do
			struct = OpenStruct.parse_json(@json2)
			parsed_json = struct.to_json
			parsed_json.gsub!(/\s/, '').must_equal @json2.gsub!(/\s/, '')
		end
	end

	describe "when the hash is joined with OpenStruct instance values" do
		it "the returned hash must be updated" do
			struct = OpenStruct.parse_hash({:name=>"Name", :gift=>{:recipients=>[{:email=>"value-1"}, {:email=>"value-2"}]}, :another=>{:title=>"Switch Me"}})
			joined_hash = struct.join({"gift"=>{"recipients_attributes"=>{"0"=>{"email"=>"value-3"}, "1"=>{"email"=>"value-4"}}}, "name"=>"New Name", "another"=> {"title"=>"Switched!"}})
			to_compare_hash = {:name=>"New Name", :gift=>{:recipients=>[{:email=>"value-3"}, {:email=>"value-4"}]}, :another=>{:title=>"Switched!"}}
			joined_hash.hash.must_equal to_compare_hash.hash
		end
	end

end
