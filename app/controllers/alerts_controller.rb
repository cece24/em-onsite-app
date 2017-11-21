class AlertsController < ApplicationController
  def new
    #code
  end

  def create
    event_id = params[:event_id]
    organization_id = params[:organization_id]

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

      if response.code == 201
        flash[:notice] = "The alert has been sent!"
        redirect_to organization_event_url(organization_id: organization_id, id: event_id)
      else
        flash[:alert] = "Sorry, there was a problem sending the alert. Please try again!"
        render :new
      end
    end
  end

end
