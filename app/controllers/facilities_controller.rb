# frozen_string_literal: true

class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.with_attached_image
    @total_count = @facilities.size
  end

  def show
    @facility = Facility.find(params[:id])
    @reviews = @facility.reviews.order(created_at: :desc)
  end
end
