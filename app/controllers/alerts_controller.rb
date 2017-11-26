require "time"

class AlertsController < ApplicationController
  def new
    @event_id = event_id
    @organization_id = organization_id
  end

  def create

    if params[:scheduled] == "true"
      date = params[:date__scheduled_date].concat(params[:time__scheduled_date]).join(" ")
      scheduled_date = Time.parse(date).utc
    else
      scheduled_date = nil
    end

    if params[:title] == "" || params[:content] == ""
      flash.now[:alert] = "Please fill in all required fields."
      render :new
    else
      response = HTTParty.post("https://core.eventmobi.com/cms/v1/events/#{event_id}/announcements",
        :headers => {
          "Content-Type" => "application/json",
          "Cookie" => exp_user
        },
        :body => {
          "title": params[:title],
          "content": params[:content],
          "scheduled": params[:scheduled],
          "send_as_email": params[:send_as_email],
          "recipient_type": "all",
          "people_group_ids": [],
          "send_as_push": false,
          "scheduled_date": scheduled_date
        }.to_json,
        :timeout => 5,
        :debug_output => $stdout
      )

      if response.code == 201
        if params[:scheduled] == "true"
          flash.now[:notice] = "The announcement has been scheduled!"
        else
          flash.now[:notice] = "The announcement has been sent!"
        end
        render :new
      else
        flash.now[:alert] = "Sorry, there was a problem sending the alert. Please try again!"
        render :new
      end
    end
  end

  private

  def organization_id
    organization_id = params[:organization_id]
  end

  def event_id
    event_id = params[:event_id]
  end

end
