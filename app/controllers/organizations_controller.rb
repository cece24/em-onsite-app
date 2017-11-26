class OrganizationsController < ApplicationController
  def index
    response = HTTParty.get("https://core.eventmobi.com/cms/v1/views/my-organizations",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      organizations = JSON.parse(response.body)
      @organizations = organizations["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to new_sessions_url
    end
  end
end
