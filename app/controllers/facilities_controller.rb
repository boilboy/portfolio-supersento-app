# frozen_string_literal: true

class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def show
    @facility = Facility.find(params[:id])
    @reviews = @facility.reviews.order(created_at: :desc)
  end
end
