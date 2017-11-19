require "json"

class PagesController < ApplicationController
  def index
    # base_uri "https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3"
    # response = HTTParty.get('https://experience.eventmobi.com/organization/eventmobi-support/event/21555/companies')
    response = HTTParty.get("https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3/sessions/resources", headers: {
        "X-API-Key" => "b809f96a3b16f08f40cd0c59847c5497d2c31255c42ab11951d273a2d4cc6c51",
        "Content-Type" => "application/json"
      })

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

end
