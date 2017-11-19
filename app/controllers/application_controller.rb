class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def experience_user
    session[:experience_user]
  end

  helper_method :experience_user
end
