class FilingController < ApplicationController
  #skip_before_filter :verify_authenticity_token,  :only => [:iframe]

  def annual
    @company = Company.find (params[:id])
    render_component(company_id: @company.id, countries: Country.all)
  end

  def home
  end

  def show
    render_component
  end

  def new
  end

  def sampler
    render :nothing
  end

  def incoming
    rrr = params[:RRR]
    orderId = params[:orderID]
    render_component rrr: rrr, orderId: orderId
  end
end
