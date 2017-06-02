class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
	  t.integer  "rate_id"
	  t.integer  "payment_id"
	  t.integer  "quantity",   default: 1

      t.timestamps
    end
  end
end
