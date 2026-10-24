# frozen_string_literal: true

class FacilitiesController < ApplicationController
  FACILITIES_COUNT = 15

  def index
    @facilities = @q.result(distinct: true).with_attached_image.page(params[:page]).per(FACILITIES_COUNT)
  end

  def show
    @facility = Facility.find(params[:id])
    @reviews = @facility.reviews.order(created_at: :desc)
  end
end
