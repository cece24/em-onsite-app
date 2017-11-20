require "json"

puts ENV["EM_API_KEY"]

class PagesController < ApplicationController
  def index
    # base_uri "https://api.eventmobi.com/v2/events/10278f43-4e8b-44f9-94ee-35cdd4d7c6d3"
    # response = HTTParty.get('https://experience.eventmobi.com/organization/eventmobi-support/event/21555/companies')
    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/21555/session-details?limit=50&offset=0&sort=date,start_time,name",
      :headers => headers_with_cookie,
      :timeout => 5,
      :debug_output => $stdout
      )

    if response.code == 200
      puts "Successful request!"
      parsed_data = JSON.parse(response.body)
      @sessions = parsed_data["data"]
    else
      puts "Request error: #{response.code} #{response.message}"
      flash[:alert] = "Whoops! Something went wrong with your request."
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
      :timeout => 5,
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
      :timeout => 5,
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
      :timeout => 5,
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

  def access
    # response = HTTParty.get("https://core.eventmobi.com/cms/v1/organizations/d8fd5bf9-b3ce-4e1d-98a0-6dbbb03b4249/events/21555",
    #   :headers => access_headers,
    #   :debug_output => $stdout
    # )

    response = HTTParty.post("https://core.eventmobi.com/cms/v1/session/action/login",
      :headers => {
        "Content-Type" => "application/json"
      },
      :body => {
        "email": "cecilia@eventmobi.com",
        "password": "Meowbot24!"
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    session[:experience_user] = response.headers["set-cookie"]
    puts session[:experience_user]

    if response.code == 200
      response_data = JSON.parse(response.body)
      @access_data = response_data
    else
      puts "Request error: #{response.code} #{response.message}"
      json_response = JSON.parse(response.body)
      puts "Bad request, parsed body"
      puts json_response
    end
  end

  def sendalert
    response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/21555/announcements",
      :headers => {
        "Content-Type" => "application/json",
        "Cookie" => experience_user
      },
      :body => {
        "title": "Kitten Boop!",
        "content": "<p>Hello!</p>",
        "scheduled": false,
        "send_as_email": false,
        "recipient_type": "all",
        "people_group_ids": [],
        "send_as_push": false,
        "scheduled_date": nil
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    render :access
  end


  private

  def get_headers
    return { "X-API-Key" => ENV["EM_API_KEY"],
      "Content-Type" => "application/json"
    }
  end

  def post_headers
    return { "X-API-Key" => ENV["EM_API_KEY"],
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  def headers_with_cookie
    return {
      "Content-Type" => "application/json",
      "Cookie" => experience_user
    }
  end

  def access_headers
    return {
      "Cookie" => "__cid=c5bca43a-f3b3-48c3-bd25-2b4a355ed990; mp_b36aa4f2a42867e23d8f9907ea741d91_mixpanel=%7B%22distinct_id%22%3A%20%22a77dd016-a032-b972-0e72-897689141d8a%22%2C%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%7D; ajs_anonymous_id=%22bd7c1289-e287-4aa9-a493-f4135b6e5aa1%22; __zlcmid=hwgf1qjuZIiYTk; intercom-id-cajd64se=5547633b-8351-4587-9ede-360469848fe7; optimizelyEndUserId=oeu1507737128256r0.3683758097336749; _mkto_trk=id:872-NUQ-221&token:_mch-eventmobi.com-1498665681324-10795; _okdetect=%7B%22token%22%3A%2215110417259700%22%2C%22proto%22%3A%22https%3A%22%2C%22host%22%3A%22experience.eventmobi.com%22%7D; _okbk=cd4%3Dtrue%2Cvi5%3D0%2Cvi4%3D1511041726689%2Cvi3%3Dactive%2Cvi2%3Dfalse%2Cvi1%3Dfalse%2Ccd8%3Dchat%2Ccd6%3D0%2Ccd5%3Daway%2Ccd3%3Dfalse%2Ccd2%3D0%2Ccd1%3D0%2C; _ok=6780-466-10-3623; _okac=7ab6ac95a53855c0eaddd5729110ad43; _okla=1; ajs_user_id=1292088; ajs_group_id=null; _ga=GA1.2.1645581020.1496168230; _gid=GA1.2.475066752.1511041725; olfsk=olfsk32191169249502183; wcsid=rrkrjUOckydRrj2q303zk0U08K0JEt6b; hblid=moyA3AgYB2FcKfpV303zk0T8RE0PorAt; __utma=224322895.1645581020.1496168230.1511047217.1511058786.130; __utmb=224322895.4.10.1511058786; __utmc=224322895; __utmz=224322895.1504806461.123.65.utmcsr=manage.eventmobi.com|utmccn=(referral)|utmcmd=referral|utmcct=/en/admin/master_list/organiser_details/10243; eventmobicomamplitudeideventmobi.com=eyJkZXZpY2VJZCI6ImRhOTYzMTg2LWQ1ZTktNDk1YS04ZjRkLThlZjIzNzQ1MGMwM1IiLCJ1c2VySWQiOm51bGwsIm9wdE91dCI6ZmFsc2UsInNlc3Npb25JZCI6MTUxMTA3MDM0OTYwMywibGFzdEV2ZW50VGltZSI6MTUxMTA3MDQzMTI5OCwiZXZlbnRJZCI6MTQ5NSwiaWRlbnRpZnlJZCI6MCwic2VxdWVuY2VOdW1iZXIiOjE0OTV9; em-login-organizer=6c23f17761f87db759510b234360fb6c7cdbb92ff4f8ed6115fd498616844ecb; _oklv=1511071398888%2CrrkrjUOckydRrj2q303zk0U08K0JEt6b"
    }
  end

end
