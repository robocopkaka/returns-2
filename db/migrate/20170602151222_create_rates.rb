class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
   	  t.string   "description"
      t.decimal  "amount"
      t.string   "code"

      t.timestamps
    end
  end
end
