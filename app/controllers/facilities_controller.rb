# frozen_string_literal: true

class FacilitiesController < ApplicationController
  def index
    @q = Facility.search_vacancies(params[:q])
    @facilities = @q.result(distinct: true).with_attached_image.page(params[:page])

    @pagination_query = pagination_params
  end

  def show
    @facility = Facility.find(params[:id])
    @reviews = @facility.reviews.order(created_at: :desc)
  end

  private

  def pagination_params
    params.permit(:page, q: %i[keyword s])
  end
end
