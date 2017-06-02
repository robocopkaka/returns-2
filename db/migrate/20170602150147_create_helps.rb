class CreateHelps < ActiveRecord::Migration[5.1]
  def change
    create_table :helps do |t|
      t.text     "description"
      t.string   "description_type"

      t.timestamps
    end
  end
end
