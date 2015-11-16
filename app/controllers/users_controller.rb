class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :show, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.includes(:shots, :pinned_shots).find(params[:id])
    if params[:tag]
      @shots = @user.shots_and_pinned_shots.find_all do |shot|
        shot.tags.map(&:name).include?(params[:tag])
      end
    else
      @shots = @user.shots_and_pinned_shots
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      @user.remember_me!
      redirect_to profile_path, notice: 'Account created!'
    else
      render :new
    end
  end

  def destroy
    authorize(params[:id])
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'Account removed.'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
