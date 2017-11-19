require "json"

class PagesController < ApplicationController
  def index
    get_headers = {
      "X-API-Key": "b809f96a3b16f08f40cd0c59847c5497d2c31255c42ab11951d273a2d4cc6c51",
      "Content-Type": "application/json"
    }
    # base_uri "https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3"
    # response = HTTParty.get('https://experience.eventmobi.com/organization/eventmobi-support/event/21555/companies')
    response = HTTParty.get("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources",
      :headers => get_headers
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
    # response = HTTParty.post("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources",
    #   headers: {
    #     "X-API-Key" => "b809f96a3b16f08f40cd0c59847c5497d2c31255c42ab11951d273a2d4cc6c51",
    #     "Content-Type" => "application/json"
    #   },
    #   body: {{
    #       "id": "1445eb89-b0a7-4a42-956d-008c9c896aef",
    #       "name": "Ninety-Nine Problems But This Post Request Is Not One of Them",
    #       "description": "<p></p>",
    #       "location": "Great Hall",
    #       "start_datetime": "2018-05-23T01:30:00",
    #       "end_datetime": "20218-05-23T03:30:00",s
    #       "track_ids": [],
    #       "tracks": [],
    #       "roles": []
    #     }
    #   }
    # )
    #
    # puts response.code

  end

  def new
    #code
  end

end
