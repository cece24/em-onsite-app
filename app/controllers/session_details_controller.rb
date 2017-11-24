class SessionDetailsController < ApplicationController
  def index
    event_id = params[:event_id]

    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/#{event_id}/session-details?limit=50&offset=0&sort=date,start_time,name",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      sessions = JSON.parse(response.body)
      @sessions = sessions["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_url(organization_id: organization_id, id: event_id)
    end
  end

  private

  def organization_id
    return params[:organization_id]
  end

  def event_id
    return params[:event_id]
  end

  def session_id
    return params["id"]
  end
end
