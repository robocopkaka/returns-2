class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.integer  "company_id"
      t.integer  "filer_id"
      t.string   "submission_type"
      t.date     "start_date"
      t.date     "end_date"

      t.timestamps
    end
  end
end
