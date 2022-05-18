# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show]
  before_action :authenticate_user!
  # load_and_authorize_resource

  # GET /reviews or /reviews.json
  def index
    @home = Home.find(params[:id])
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show; end

  # GET /reviews/new
  def new
    @home = Reservation.find_by(id: params[:reservation]).home
    @review = Review.new
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @home = Home.find_by(id: @review.home_id)
    respond_to do |format|
      if @review.save
        format.html { redirect_to reservations_url(), notice: 'Review was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:score, :comment, :home_id, :guest_id)
  end
end
