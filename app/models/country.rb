class Country < ActiveRecord::Base

  def self.all
  	ISO3166::Country.all.map(&:name).sort
  end

  def self.states(country)
  	@states = []
  	@states = ISO3166::Country.find_country_by_name(country).states.map {|k,v| v["name"]}
  	if @states.empty?
  		@states[0] = country
  	end
  	@states
  end

end