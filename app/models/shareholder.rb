class Shareholder < ApplicationRecord
	#validates :surname, :first_name, :nationality, :residential_address, presence: true
  #validates :residential_address_city, :residential_address_country, :residential_address_state, presence: true

  belongs_to :company
  # has_paper_trail
end
