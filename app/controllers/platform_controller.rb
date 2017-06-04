class PlatformController < ApplicationController
  # before_filter :set_company!, except: [:index, :error]

  def index
    unless (@company = current_company).nil?
      redirect_to company_path @company
    end
  end

  def error
  end

  def country_states
  	@country_states = Country.states params[:country]
  	respond_to do |format|
  		format.json { render json: @country_states }
  	end
  end
end
