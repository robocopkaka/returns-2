class CreateFilers < ActiveRecord::Migration[5.1]
  def change
    create_table :filers do |t|
      t.string   "surname"
      t.string   "first_name"
      t.string   "other_names"
      t.string   "accreditation_number"
      t.string   "address"
      t.string   "address_2"
      t.string   "city"
      t.string   "filer_state"
      t.string   "tel_number"
      t.string   "email"
      t.date     "filer_date"
      t.timestamps
    end
  end
end
