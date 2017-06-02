class Filer < ApplicationRecord
  #validates :surname, :first_name, :accreditation_number, :address, presence: true
  #validates :city, :filer_state, :tel_number, :email, presence: true

  belongs_to :company
end
