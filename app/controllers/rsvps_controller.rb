class RsvpsController < ApplicationController

  # DISABLE 3rd party POST request detection
  skip_before_filter :verify_authenticity_token, :only => "receive_response_from_player"

  def update
    p params
    @rsvp = Rsvp.find(params[:id])
    @rsvp.update(response_params)
    redirect_to game_path(@rsvp.game)
    #twilio logic. Buttons on game show page
  end

  # TWILIO sends a post request here
  def receive_response_from_player

    # Find the player by the phone number that sent the text
    player_who_sent_message = Player.find_by(phone_number: params['From'])
    
    # Get the game from the user-specified game ID
    id_user_sent = params['Body'].split[" "].last.to_i
    game = Game.find_by(id: id_user_sent)

    # Get the Rsvp between the game and the player
    rsvp = Rsvp.where(player: player_who_sent_message, game: game)

    if rsvp
      if params['Body'].downcase == 'yes'
        #set response to yes

        rsvp.update(response: "yes")

        response = Twilio::TwiML::Response.new do |r|
          r.Message "You have confirmed that you WILL be going to the game."
        end

        render :xml => response.to_xml

      elsif params['Body'].downcase == 'no'
        #set response to no

        rsvp.update('no')

        response = Twilio::TwiML::Response.new do |r|
          r.Message "You have confirmed that you WILL NOT be going to the game."
        end

        render :xml => response.to_xml
      else
        #invalid text received
        response = Twilio::TwiML::Response.new do |r|
          r.Message "Sorry, I'm a dumb robot and couldn't understand that. Please respond with either 'yes #{game.id}' or 'no #{game.id}'."
        end

        render :xml => response.to_xml
      end
    else
      # There is no Rsvp for this player
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Hmmm... I can't seem to find a game that you are playing in. Please contact your coach for help."
      end

      render :xml => response.to_xml
    end
  end

  private

  def response_params
    params.require(:rsvp).permit(:response)
  end

end
