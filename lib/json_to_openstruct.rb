require 'string_helper'

module JsonToOpenStruct

	def self.included(host_class)
    host_class.extend ClassMethods
  end

	def to_json
		hash = self.to_hash
		hash.to_json
	end

	def to_hash
		hash = {}
		self.to_h.each do |key, value|
			if self[key].kind_of?(Array)
				hash[key] = []
				self[key].each do |array_item|
					hash[key] << array_item.to_hash
				end
			elsif self[key].kind_of?(self.class)
				hash[key] = value.to_hash
			else
				hash[key] = value
			end
		end
		hash
	end

	def join(params)
		hash = self.to_hash
		parse(hash, params)
		hash
	end

	private

	def parse(hash, params)
		params.keys.each do |key|
			if params[key].kind_of?(Hash)
				if key.end_with?("_attributes")
					params[key].keys.each do |index|
						parse(hash[StringHelper.normalize(key).to_sym][index.to_i], params[key][index])
					end
				else
					parse(hash[key.to_sym], params[key])
				end
			else
				hash[key.to_sym] = params[key]
			end
		end
	end

	module ClassMethods

		def parse_hash(hash)
			struct = self.new
			hash.keys.each do |key|
				attr_name = StringHelper.underscore(key.to_s)
				struct.send(attr_name)
				if hash[key].kind_of?(Array)
					struct[attr_name] = []
					hash[key].each do |arr_item|
						struct[attr_name] << self.parse_hash(arr_item)
					end
				elsif hash[key].kind_of?(Hash)
					struct[attr_name] = self.parse_hash(hash[key])
				else
					struct[attr_name] = hash[key]
				end
			end
			struct
		end

		def parse_json(json)
			hash = JSON.parse(json)
			parse_hash(hash)
		end

	end
end
