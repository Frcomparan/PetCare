class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  # PATCH/PUT /users/1 or /users/1.json
  def verify
    @user.update(verified: !@user.verified)
  end

  def profile
    @user = current_user
  end
end
