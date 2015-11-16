class GuestsController < ApplicationController
  skip_before_filter :require_login, only: [:create]

  def create
    username = "guest_#{Time.now.to_i}#{rand(100)}"
    email = "#{username}@example.com"
    password = SecureRandom.hex(24)

    @guest = User.create({
      username: username,
      email: email,
      password: password,
      password_confirmation: password,
      guest: true
    })

    if @guest.save
      auto_login(@guest)
      @guest.remember_me!
      redirect_to profile_path, notice: "Guest account created, have fun!"
    else
      redirect_to root_path, alert: "Something went wrong. :/"
    end
  end

  def edit
    authorize(params[:id])
    @guest = current_user
  end

  def update
    authorize(params[:id])
    @guest = current_user
    if @guest.update_attributes(guest_params)
      @guest.update_attribute(:guest, false)
      redirect_to profile_path, notice: "You are now a regular member!"
    else
      render :edit
    end
  end

  def guest_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
