class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string   "merchantId"
      t.string   "serviceTypeId"
      t.string   "orderId"
      t.string   "payerName"
      t.string   "payerEmail"
      t.string   "payerPhone"
      t.string   "amount"
      t.string   "reference"
      t.integer  "company_id"
      t.string   "workflow_state"

      t.timestamps
    end
  end
end
