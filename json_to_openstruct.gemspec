Gem::Specification.new do |s|
  s.name        = 'json_to_openstruct'
  s.version     = '0.1.0'
  s.date        = '2017-12-05'
  s.summary     = "A simple Ruby gem adding a functionality to OpenStruct to load deep nested json objects and hashes as OpenStruct. It also adds a posibility to generate json and hash back."
  s.description = "A simple Ruby gem adding OpenStruct::parse_json and OpenStruct::parse_hash methods and reverse OpenStruct#to_hash and OpenStruct#to_json methods to (obviously) OpenStruct. It is able to parse and reconstruct nested json and hash objects as well. There is also a OpenStruct#join method adding possibility to replace values in the hash tree with the values passed as a hash in parameter (supporting accepts_nested_attributes_for format) and return it as a new hash."
  s.authors     = ["Jiri Prochazka"]
  s.email       = 'prochazka@coderocket.co'
  s.files       = ["lib/json_to_openstruct.rb", "lib/string_helper.rb"]
  s.homepage    = 'https://github.com/CodeRocketCo/json_to_openstruct'
  s.license     = 'MIT'
	s.add_runtime_dependency "json", "~> 2.0"
end
