class RsvpsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => "update"

  def update
    #twilio logic. Buttons on game show page
  end

end
