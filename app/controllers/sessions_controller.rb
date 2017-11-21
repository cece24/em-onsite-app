class SessionsController < ApplicationController
  def new
    #code
  end

  def create
    login_payload = {
      "email": params[:email],
      "password": params[:password]
    }

    response = HTTParty.post("https://core.eventmobi.com/cms/v1/session/action/login",
      :headers => {
        "Content-Type" => "application/json"
      },
      :body => login_payload.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    session[:exp_user] = response.headers["set-cookie"]
    puts session[:exp_user]

    if response.code == 200
      redirect_to organizations_url
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Please check your credentials and try again."
      render :new
    end
  end

  def destroy
    session[:exp_user] = nil

    redirect_to new_session_url
  end
end
