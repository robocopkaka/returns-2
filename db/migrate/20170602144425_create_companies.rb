class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
        t.string   "name"
	    t.string   "authorization_code"
	    t.integer  "rc_number"
	    t.integer  "company_type_id"
	    t.date     "incorporation_date"
	    t.boolean  "email_reminder"
	    t.text     "registered_office_address"
	    t.string   "registered_office_city"
	    t.string   "registered_office_state"
	    t.date     "annual_return_date"
	    t.date     "accounts_date"
	    t.integer  "auth_share_capital",          limit: 8
	    t.integer  "number_of_shares",            limit: 8
	    t.decimal  "share_price"
	    t.integer  "issued_share_capital",        limit: 8
	    t.integer  "paid_up_capital",             limit: 8
	    t.string   "registered_office_address_2"
	    t.string   "registered_office_po"
	    t.string   "situation_address"
	    t.string   "situation_address_2"
	    t.string   "situation_city"
	    t.string   "situation_state"
	    t.string   "email"
	    t.string   "zonal_office"
	    t.jsonb    "tstore",                                default: {}, null: false

        t.timestamps
    end
  end
end
