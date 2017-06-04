class CompaniesController < ApplicationController
	# before_action :set_company!, except: [:retrieve]
  before_action :set_company, only: [:show, :edit, :update]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  def retrieve
    respond_to do |format|
      unless res=create_company_session(params[:rc_number], params[:authorization_code]) == false
        @company = current_company
        format.html { redirect_to @company }
        format.json { render :show, status: :retrieved, location: @company }
      else
        format.html {redirect_to platform_index_path, alert: "ERROR: RC Number with Authorization Code Not Valid"}
      end 
    end     
  end

  # POST /companies
  # POST /companies.json
  # def create
  #   @company = Company.new(company_params)

  #   respond_to do |format|
  #     if @company.save
  #       format.html { redirect_to @company, notice: 'Company was successfully created.' }
  #       format.json { render :show, status: :created, location: @company }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @company.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      
      if @company.update(tstore: params[:company]["tstore"]) 
        @payment = @company.process_tstore_and_generate_bill
        format.html { redirect_to new_payment_path }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # # DELETE /companies/1.json
  # def destroy
  #   @company.destroy
  #   respond_to do |format|
  #     format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      # @company = Company.find(params[:id])
      @company = current_company # calls the  current_company method in ApplicationController
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :authorization_code, :rc_number, :company_type_id, :incorporation_date, :email_reminder, :registered_office_address, :registered_office_city, :registered_office_state, :annual_return_date, :accounts_date, tstore: [])
    end
end
