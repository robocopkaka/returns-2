class CreateOfficers < ActiveRecord::Migration[5.1]
  def change
    create_table :officers do |t|
      t.string   "surname"
      t.string   "first_name"
      t.string   "other_names"
      t.string   "nationality"
      t.date     "dob"
      t.string   "tel_number"
      t.text     "residential_address"
      t.string   "residential_address_city"
      t.string   "residential_address_state"
      t.string   "residential_address_pob"
      t.string   "residential_address_country"
      t.string   "email"
      t.string   "occupation"
      t.text     "particulars_of_other_directorship"
      t.string   "role"
      t.integer  "company_id"

      t.timestamps
    end
  end
end
