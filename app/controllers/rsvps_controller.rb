class RsvpsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => "update"

  def update
    p params
    @rsvp = Rsvp.find(params[:id])
    @rsvp.update(response_params)
    redirect_to game_path(@rsvp.game)
    #twilio logic. Buttons on game show page
  end

  private

  def response_params
    params.require(:rsvp).permit(:response)
  end

end
