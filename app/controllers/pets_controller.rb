# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /pets or /pets.json
  def index
    @pets = Pet.all.where(user_id: current_user)
  end

  # GET /pets/1 or /pets/1.json
  def show; end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit; end

  # POST /pets or /pets.json
  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user

    respond_to do |format|
      if @pet.save
        format.html { redirect_to pet_url(@pet), notice: 'Pet was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to pet_url(@pet), notice: 'Pet was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet.destroy

    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def pet_params
    params.require(:pet).permit(:name, :breed, :description, :user_id, :photo)
  end
end
