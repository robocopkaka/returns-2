class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  # before_action :set_company!
  #before_action :set_paper_trail_whodunnit
  # skip_before_filter :verify_authenticity_token,  :only => [:iframe]

  def set_company!
    if session[:current_company_id].nil?
      redirect_to platform_index_path
    end
  end


  private

  def create_company_session(rc_number, auth_code)
    @company = Company.where(rc_number: rc_number, authorization_code: auth_code, email: current_user.email)
    unless @company.empty?
      session[:current_company_id] = @company.first.id
    else
      false      
    end
  end

  def current_company
    @_current_company ||= session[:current_company_id] && Company.find_by(id: session[:current_company_id])
  end
end
