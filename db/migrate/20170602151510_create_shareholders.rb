class CreateShareholders < ActiveRecord::Migration[5.1]
  def change
    create_table :shareholders do |t|
      t.string   "surname"
      t.string   "first_name"
      t.string   "other_names"
      t.string   "nationality"
      t.date     "dob"
      t.string   "residential_address"
      t.string   "residential_address_city"
      t.string   "residential_address_state"
      t.string   "residential_address_country"
      t.decimal  "holding"
      t.integer  "company_id"

      t.timestamps
    end
  end
end
