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
    # session_received = {
    #   "id": params[:id],
    #   "name": params[:name],
    #   "description": params[:description],
    #   "location": params[:location],
    #   "start_datetime": params[:start_time] + ":00",
    #   "end_datetime": params[:end_time] + ":00"
    # }

    # session_received = {
    #   id: "greatestideverup4345",
    #   name: "Kitty Booping",
    #   description: "Properly boop your cats with this information lesson!",
    #   location: "Hall of MAOs",
    #   start_datetime: "2018-05-23T10:00:00",
    #   end_datetime: "2018-05-23T12:00:00"
    # }
    #
    # json_body = session_received.to_json
    #
    # puts "JSON Body"
    # puts json_body
    # puts json_body.class

    response = HTTParty.post("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources",
      :headers => post_headers,
      body: {
          "id": "1445eb96aef",
          "name": "Ninety-Nine Problems But This Post Request was 1000",
          "description": "<p>Changes in how we live, communicate, do business, move and interact are taking place at an ever-increasing pace. We face new challenges each day. Through best practices, your in-house API won'\''t be one of them. We show you how to transform to meet the need of users to facilitate rapid change by re-imagining processes and requirements and adopting new technologies. Harnessing a need for change as an opportunity to positively shift the way we design, shape internal    environments.</p>",
          "location": "Great Hall",
          "start_datetime": "2020-11-08T01:30:00",
          "end_datetime": "2020-11-08T01:30:00",
          "track_ids": [],
          "tracks": [],
          "roles": []
        }.to_json,
      :debug_output => $stdout
    )

    if response.code == 200
      puts "Successful post request!"
      puts "Response received: #{response}"
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
