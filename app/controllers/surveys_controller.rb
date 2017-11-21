class SurveysController < ApplicationController
  def index
    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/21555/surveys",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      survey_data = JSON.parse(response.body)
      all_surveys = survey_data["data"]
      @surveys = all_surveys.select { |key, value|
        key["type"] == "survey"
      }

      @session_feedback_surveys = all_surveys.select { |key, value|
        key["type"] == "session_feedback"
      }
    else
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to root_url
    end
  end

  def survey_show
    response = HTTParty.patch("https://core.eventmobi.com/cms/v1/events/21555/surveys/#{survey_id}",
      :headers => exp_headers,
      :body => {
        "event_id"  => event_id,
        "id"        => survey_id,
        "visible"   => true
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash.now[:notice] = "The survey is now visible."
      redirect_to surveys_url
    else
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to surveys_url
    end
  end

  def survey_hide
    response = HTTParty.patch("https://core.eventmobi.com/cms/v1/events/21555/surveys/#{survey_id}",
      :headers => exp_headers,
      :body => {
        "event_id"  => event_id,
        "id"        => survey_id,
        "visible"   => false
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash.now[:notice] = "The survey is now hidden."
      redirect_to surveys_url
    else
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to surveys_url
    end
  end

  private

  def event_id
    return params["event_id"]
  end

  def survey_id
    return params["id"]
  end
end
