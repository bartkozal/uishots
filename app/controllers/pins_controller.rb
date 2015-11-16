class PinsController < ApplicationController
  def create
    find_user_and_shot
    Pin.create(user: @user, shot: @shot)
    redirect_to :back
  end

  def destroy
    find_user_and_shot
    Pin.find_by(user: @user, shot: @shot).destroy
    redirect_to :back
  end

  def find_user_and_shot
    authorize(params[:user_id])

    @user = User.find(params[:user_id])
    @shot = Shot.find(params[:shot_id])
  end
end
