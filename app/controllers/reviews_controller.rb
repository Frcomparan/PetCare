# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_reservation, only: %i[show]
  before_action :authenticate_user!
  # load_and_authorize_resource

  # GET /reviews or /reviews.json
  def index
  end

  # GET /reviews/1 or /reviews/1.json
  def show; end

  # GET /reviews/new
  def new
  end

  # POST /reviews or /reviews.json
  def create
    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: 'Review was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:home_id, :check_in, :check_out, :pets_number, :amount, :status)
  end
end
