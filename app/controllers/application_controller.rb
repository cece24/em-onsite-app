class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

end
