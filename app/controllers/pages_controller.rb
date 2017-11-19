require "json"

class PagesController < ApplicationController
  def index
    # base_uri "https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3"
    # response = HTTParty.get('https://experience.eventmobi.com/organization/eventmobi-support/event/21555/companies')
    response = HTTParty.get("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources",
      :headers => get_headers,
      :debug_output => $stdout
      )

    if response.code == 200
      puts "Successful request!"
      puts "Response received: #{response}"
      parsed_data = JSON.parse(response.body)
      @sessions = parsed_data["data"]
      puts "Selected data now looks like: #{@sessions}"
    else
      puts "Request error: #{response.code}"
    end

  end

  def create
    #Create a session
    session_received = {
      "id": params[:id],
      "name": params[:name],
      "description": params[:description],
      "location": params[:location],
      "start_datetime": params[:start_time] + ":00",
      "end_datetime": params[:end_time] + ":00",
      "track_ids": [],
      "tracks": [],
      "roles": []
    }

    response = HTTParty.post("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources",
      :headers => post_headers,
      :body => session_received.to_json,
      :debug_output => $stdout
    )

    if response.code == 201
      redirect_to root_url
    else
      puts "Request error: #{response.code} #{response.message}"
      json_response = JSON.parse(response.body)
      puts "Bad request, parsed body"
      puts json_response
    end

  end

  def new

  end

  private

  def get_headers
    return { "X-API-Key" => "b809f96a3b16f08f40cd0c59847c5497d2c31255c42ab11951d273a2d4cc6c51",
      "Content-Type" => "application/json"
    }
  end

  def post_headers
    return { "X-API-Key" => "b809f96a3b16f08f40cd0c59847c5497d2c31255c42ab11951d273a2d4cc6c51",
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

end
