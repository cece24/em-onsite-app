require 'digest'

class SessionDetailsController < ApplicationController
  def index
    @event_id = event_id
    @organization_id = organization_id

    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/#{event_id}/session-details?limit=50&offset=0&sort=date,start_time,name",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      sessions = JSON.parse(response.body)

      sessions["data"].each do |session|
        session["poll_payload"] = get_poll_questions(session["id"])
        session["question_moderation_link"] = "https://experience.eventmobi.com/event/#{event_id}/question//moderate-live-results/#{Digest::SHA256.hexdigest "#{event_id},#{session["id"]}"}/ask_a_question/#{session["id"]}"
      end

      @sessions = sessions["data"]
      puts @sessions
    else
      puts "Request error: #{response.code} #{response.message}"
      flash.now[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_url(organization_id: organization_id, id: event_id)
    end
  end

  def question_enable
    response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/#{event_id}/session/toggle-ask-a-question",
      :headers => exp_headers,
      :body => {
        "id" => session_id
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash[:notice] = "This session is now accepting new questions."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    end
  end

  def question_disable
    response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/#{event_id}/session/toggle-ask-a-question",
      :headers => exp_headers,
      :body => {
        "id" => session_id
      }.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash[:notice] = "This session is no longer accepting new questions."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    end
  end

  def get_poll_questions(session_detail_id)
    response = HTTParty.get("https://core.eventmobi.com/cms/v1/events/#{event_id}/live-polls/questions?session_id=#{session_detail_id}&sort=order",
      :headers => exp_headers,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      poll_question_data = JSON.parse(response.body)
      poll_questions = poll_question_data["data"]

      if !poll_questions.empty?
        poll_payload = {}

        poll_payload["question_ids"] = poll_questions.map do |question|
          question["id"]
        end

        poll_payload["visible"] = poll_questions[0]["visible"]

        return poll_payload
      end
    else
      puts "Request error!"
    end
  end

  def poll_show
    payload = JSON.parse(params[:poll_payload])
    payload["visible"] = true

    response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/#{event_id}/live-polls/questions/action/hide",
      :headers => exp_headers,
      :body => payload.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash[:notice] = "Live polls for this session are now visible to attendees."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    end
  end

  def poll_hide
    payload = JSON.parse(params[:poll_payload])
    payload["visible"] = false

    response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/#{event_id}/live-polls/questions/action/hide",
      :headers => exp_headers,
      :body => payload.to_json,
      :timeout => 5,
      :debug_output => $stdout
    )

    if response.code == 200
      flash[:notice] = "Live polls for this session are now hidden from attendees."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
    else
      flash[:alert] = "Whoops! Something went wrong with your request."
      redirect_to organization_event_session_details_url(organization_id: organization_id, id: event_id)
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
