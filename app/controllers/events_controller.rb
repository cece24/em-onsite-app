class EventsController < ApplicationController
  def index
    organization_id = params[:organization_id]

    response = HTTParty.get("https://core.eventmobi.com/cms/v1/organizations/#{organization_id}/events?limit=50&offset=0&sort=-start_date",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      events = JSON.parse(response.body)
      @events = events["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organizations_url
    end
  end

  def show
    organization_id = params[:organization_id]
    @organization_id = organization_id
    event_id = params[:id]
    @event_id = event_id

    response = HTTParty.get("https://core.eventmobi.com/cms/v1/organizations/#{organization_id}/events/#{event_id}",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      event_data = JSON.parse(response.body)
      @event_data = event_data["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organizations_url
    end
  end
end
