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
      parsed_data = JSON.parse(response.body)
      @sessions = parsed_data["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
    end

  end

  def new

  end

  def create
    #Create a session
    session_received = {
      "id": params[:id],
      "name": params[:name],
      "description": params[:description],
      "location": params[:location],
      "start_datetime": params[:start_time],
      "end_datetime": params[:end_time],
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

  def edit
    # get request for the session with params ID
    session_id = params[:id]
    response = HTTParty.get("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources/#{session_id}",
      :headers => get_headers,
      :debug_output => $stdout
    )
    # pass it as instance to form
    if response.code == 200
      puts "Successful request!"
      parsed_data = JSON.parse(response.body)
      parsed_data["data"]["start_time"] = parsed_data["data"]["start_datetime"].chomp("-05:00")
      parsed_data["data"]["end_time"] = parsed_data["data"]["end_datetime"].chomp("-05:00")
      @session = parsed_data["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
    end
  end

  def update
    session_update = {
      "name": params[:name],
      "description": params[:description],
      "location": params[:location],
      "start_datetime": params[:start_time],
      "end_datetime": params[:end_time],
      "track_ids": [],
      "tracks": [],
      "roles": []
    }

    session_id = params[:id]

    response = HTTParty.patch("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources/#{session_id}",
      :headers => post_headers,
      :body => session_update.to_json,
      :debug_output => $stdout
    )

    if response.code == 200
      redirect_to root_url
    else
      puts "Request error: #{response.code} #{response.message}"
      json_response = JSON.parse(response.body)
      puts "Bad request, parsed body"
      puts json_response
    end

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
