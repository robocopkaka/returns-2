class Payment < ApplicationRecord
  belongs_to :company
  has_many :line_items, dependent: :destroy

  include Workflow

  workflow do
    state :new do 
      event :submit, :transitions_to => :pending
    end

    state :pending do
      event :paid, :transitions_to => :paid
    end

    state :completed do
      event :revert, :transitions_to => :pending
    end
      
  end


  def generate_transaction_order(res)
    res.each do |k, v|
      rate = Rate.where(code: k).first
      unless rate.nil?
        LineItem.find_or_create_by(rate_id: rate.id, payment_id: id)
      end
    end
  end
end
