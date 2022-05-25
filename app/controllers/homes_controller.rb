# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token,  only: [:search, :index]

  # GET /homes or /homes.json
  def index
    @ids = params[:homes_ids] if params.key?(:homes_ids)
    @homes = params.key?(:homes_ids) ? Home.where(id: @ids) : Home.all
    @homes = @homes.search_filter(params[:filter]) if params.key?(:filter)
  end

  # GET /homes/1 or /homes/1.json
  def show
    @reviews = Review.where(home: @home).limit(4)
    @meetings = @home.reservations.reserved_dates
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
    delete_attachment(params[:photo_id]) if params.key?(:photo_id)
  end

  # POST /homes or /homes.json
  def create
    @home = Home.new(home_params)
    @home.user = current_user

    respond_to do |format|
      if @home.save
        format.html { redirect_to home_url(@home), notice: 'Home was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1 or /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to home_url(@home), notice: 'Home was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1 or /homes/1.json
  def destroy
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
    end
  end

  def delete_attachment(photo_id)
    attachment = ActiveStorage::Attachment.find(photo_id)
    attachment.purge
    redirect_to edit_home_url(@home)
  end

  def search
    @ids = params[:ids].split(',')
    if params[:llegada] != "" && params[:salida] != "" 
      @ids = @ids.reject { |id| (Reservation.valid_create(params[:salida], params[:llegada], id).size > 0) }
    end
    @homes = Home.where(id: @ids)
    render action: "index", locals: { homes: @homes, ids: @ids }
  end

  private

  # Only allow a list of trusted parameters through.
  def home_params
    params.require(:home).permit(:title, :address, :latitude, :longitude, :description, :price, :score, :user_id, photos: [])
  end
end
