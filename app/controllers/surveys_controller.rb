class SurveysController < ApplicationController
  def index
    organization_id = params[:organization_id]
    @organization_id = organization_id
    event_id = params[:event_id]
    @event_id = event_id

    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/#{event_id}/surveys",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      survey_data = JSON.parse(response.body)
      all_organization_event_surveys = survey_data["data"]
      @surveys = all_organization_event_surveys.select { |key, value|
        key["type"] == "survey"
      }

      @session_feedback_surveys = all_organization_event_surveys.select { |key, value|
        key["type"] == "session_feedback"
      }
    else
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_url(organization_id: organization_id, id: event_id)
    end
  end

  def survey_show
    response = HTTParty.patch("https://core.eventmobi.com/cms/v1/events/#{event_id}/surveys/#{survey_id}",
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
      flash[:notice] = "The survey is now visible."
      redirect_to organization_event_surveys_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_surveys_url(organization_id: organization_id, id: event_id)
    end
  end

  def survey_hide
    response = HTTParty.patch("https://core.eventmobi.com/cms/v1/events/#{event_id}/surveys/#{survey_id}",
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
      flash[:notice] = "The survey is now hidden."
      redirect_to organization_event_surveys_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_surveys_url(organization_id: organization_id, id: event_id)
    end
  end

  private

  def organization_id
    return params[:organization_id]
  end

  def event_id
    return params[:event_id]
  end

  def survey_id
    return params["id"]
  end
end
