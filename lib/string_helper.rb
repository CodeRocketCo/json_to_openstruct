module StringHelper
	def self.underscore(word)
		word.split(/(?=[A-Z])/).each { |str| str.downcase! }.join("_")
	end

	def self.normalize(word)
		underscore(word.sub(/_attributes/, ''))
	end

	def self.is_i?(word)
		/\A[-+]?\d+\z/ === word
	end
end
