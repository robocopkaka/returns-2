class Help < ApplicationRecord
	def self.get_guide(step)
		Help.find_by_description_type(step)
	end
end
