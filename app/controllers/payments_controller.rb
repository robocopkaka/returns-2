class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @company = current_company
    #select the services and cost from rates table; include them in @rates
    amt = 0.00
    # @rates.map {|r| amt = amt + r.amount}
    amt = rand(1000..20000)
    mid = Rails.application.secrets.remita_merchant_id.to_s
    sid = Rails.application.secrets.remita_service_type_id.to_s
    akey = Rails.application.secrets.remita_api_key.to_s
    payer_name = "Sola Allinson"
    payer_email = "sola_allison@yahoo.com"
    payer_phone = "08087723454"
    ref = "Sample Reference for Item"

    @payment = @company.current_payment

    @payment.update(merchantId: mid, serviceTypeId: sid, \
      payerName: payer_name, payerEmail: payer_email, payerPhone: payer_phone, amount: amt, \
      reference: ref)
    # @payment.submit!
    @hash = Digest::SHA512::hexdigest(mid + sid + (@payment.id + 1000000).to_s + @payment.amount.to_s + payments_return_url + akey)

  end

  # GET /payments/1/edit
  def edit
  end

  def remita_return
    rrr = params["RRR"]
    orderId = params["OrderId"]
    unless rrr.nil? or orderId.nil?
      if confirm_transaction_status(rrr, orderId)
        pid = orderId.to_i - 1000000   #change at production
        Payment.transaction do
          @payment.paid!
          transaction_payment_completed pid
        end
      end
    end

  end

  def temp_poster
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:merchantId, :serviceTypeId, :orderId, :payerName, :payerEmail, :payerPhone, :amount, :reference)
    end

    def confirm_transaction_status(rrr, orderId)
      hash = Digest::SHA512::hexdigest(rrr + Rails.application.secrets.remita_api_key.to_s + Rails.application.secrets.remita_merchant_id.to_s)
      link = ("http://www.remitademo.net/remita/ecomm/" + Rails.application.secrets.remita_merchant_id.to_s + "/#{rrr}/" + hash + "/status.reg")
      response = RestClient.get link,  {accept: :json}
      jres = JSON.parse response.body
      unless jres.nil? || jres["orderId"] != orderId
        pid = orderId.to_i - 1000000   #change at production
        if (Payment.find pid).amount == jres["amount"]
          return false
        else
          true
        end
      else
        false
      end
    end

    def transaction_payment_completed(pid)
      p = Payment.find pid
      @company = p.company
      @company.commit_tstore_details  #The step should be @company.queue_filing_for_review
    end
end
