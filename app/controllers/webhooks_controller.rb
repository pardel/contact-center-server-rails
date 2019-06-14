class WebhooksController < ApplicationController

  skip_before_action :check_nexmo_api_credentials
  skip_before_action :verify_authenticity_token


  def answer
    ncco = @nexmo_app.voice_answer_ncco({webhooks_dtmf_url: webhooks_dtmf_url})
    if ncco.blank?
      render json: []
      return
    end
    ncco = ncco.sub("PARAMS_TO", (params[:to] || ""))
    render json: ncco
  end

  def event
    # logger.debug request.body.read
    EventLog.create(event_type: 'voice', content: request.body.read)
    head :ok
  end

  def dtmf
    # params.each do |key,value|
    #   Rails.logger.warn "Param #{key}: #{value}"
    # end
    case params[:dtmf]
    when "1"
      render json: Ncco.ivr_jane
    when "2"
      render json: Ncco.ivr_joe

)
    else 
      head :ok
    end
  end

end
