class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :require_login
  skip_before_filter :require_login, only: [:home]

  def home
  end

  protected

  def authorize(user_id)
    not_authorized unless user_id.to_i == current_user.id
  end

  private

  def not_authorized
    redirect_back_or_to root_path, alert: "You don't have that access"
  end

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
