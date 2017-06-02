class Company < ApplicationRecord
  #validates :registered_office_address, :registered_office_city, :registered_office_state, :zonal_office, presence: true
  #validates :situation_address, :situation_city, :situation_state, presence: true
  #validates :auth_share_capital, :number_of_shares, :share_price, :issued_share_capital, :paid_up_capital, presence: true

  has_many :officers, dependent: :destroy
  has_many :shareholders, dependent: :destroy
  has_many :filers, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :submissions, dependent: :destroy
  # has_paper_trail

  def process_tstore_and_generate_bill
    aggregate = aggregate_change_record
    curr = current_payment
    curr.generate_transaction_order aggregate 
    curr  
  end

  def current_payment
    active_payments = Payment.where(company_id: id).where.not(workflow_state: "completed") 
    curr = active_payments.empty? ? payments.create : active_payments.first
  end

  def aggregate_change_record
    changeset = {"reg"=>{}, "sit"=>{}, "cap"=>{}, "off"=>{}, "sha"=>{}, "fil"=>{}}
    tstore.each do |k, v|
      nk = k[0,3]
      if (%w(reg sit cap fil off).include? nk)
        changeset[nk][k] = v unless (v.nil?) # && v.empty?)
      elsif (%w(off sha).include? nk)
        changeset[nk] = v unless (v.nil?)
      end
    end
    changeset
  end

  def queue_filing_for_review
    # submissions.create(submission_type: returns)
    s = submissions.create(submission_type: accounts)
    d = incorporation_date
    s.end_date  = Date.new( Date.today.year + 1, d.month, d.day - 1)
    s.start_date = e = Date.new( Date.today.year, d.month, d.day)
  end

  def commit_tstore_details

  #list of all attributes
    registered_office_address = tstore["reg_address"]
    registered_office_address_2 = tstore["reg_address_2"]
    registered_office_city = tstore["reg_city"]
    registered_office_state = tstore["reg_state"]
    registered_office_po = tstore["reg_po"]
    zonal_office = tstore["reg_zone"]
    auth_share_capital = tstore["auth_share_capital"]
    number_of_shares = tstore["number_of_shares"]
    issued_share_capital = tstore["issued_share_capital"]
    paid_up_capital = tstore["paid_up_capital"]
    situation_address = tstore["sit_address"]
    situation_address_2 = tstore["sit_address_2"]
    situation_city = tstore["sit_city"]
    situation_state = tstore["sit_state"]
    save

    #surname
    #fname
    #oname
    #address
    #address2
    #nationality
    #city
    #state
    #country
    #email
    #pod
    #dob!
    #tel_number
    #occupation
    #role

    # surname
    # fname
    # oname
    # address
    # address2
    # nationality
    # city
    # state
    # country
    # holding


    # filer_surname
    # filer_fname
    # filer_oname
    # filer_accr
    # filer_address
    # filer_address_2
    # filer_city
    # filer_state
    # filer_tel_number
    # filer_email





  #list of all attributes
    # reg_address
    # reg_address_2
    # reg_city
    # reg_state
    # reg_po
    # reg_zone
    # auth_share_capital
    # number_of_shares
    # issued_share_capital
    # paid_up_capital
    # sit_address
    # sit_address_2
    # sit_city
    # sit_state

    #surname
    #fname
    #oname
    #address
    #address2
    #nationality
    #city
    #state
    #country
    #email
    #pod
    #dob!
    #tel_number
    #occupation
    #role

    # surname
    # fname
    # oname
    # address
    # address2
    # nationality
    # city
    # state
    # country
    # holding


    # filer_surname
    # filer_fname
    # filer_oname
    # filer_accr
    # filer_address
    # filer_address_2
    # filer_city
    # filer_state
    # filer_tel_number
    # filer_email
  end

  def submission_status
    ret = {returns: false, accounts: false}
    last_returns = submissions.where(submission_type: "returns").first
    last_accounts = submissions.where(submission_type: "accounts").first
    ret[:returns] = last_returns.end_date < Date.today unless last_returns.nil?
    ret[:accounts] = last_accounts.end_date < Date.today unless last_accounts.nil?
    ret
  end
end
