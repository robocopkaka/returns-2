class Submission < ApplicationRecord
  belongs_to :company

  def self.create_submission(company_id, start_date, end_date, sub_type)
  end
end
