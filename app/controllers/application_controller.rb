class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :ensure_authentication

  def exp_user
    session[:exp_user]
  end

  helper_method :exp_user

  def exp_headers
    return {
      "Content-Type" => "application/json",
      "Cookie" => exp_user
    }
  end

  def ensure_authentication
    if !session[:exp_user]
      redirect_to new_sessions_url
      flash[:alert] = "Please log in."
    end
  end

end
