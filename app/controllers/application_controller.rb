# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ransack, if: -> { controller_name.in?(%w[tops facilities]) }

  private

  def set_ransack
    @q = Facility.search_vacancies(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname avatar terms])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname avatar])
  end
end
