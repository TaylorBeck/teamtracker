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
    boot_twilio

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

        manager_phone = rsvp.game.team.manager.phone_number
        team_name = rsvp.game.team.name
        # Get date as 'Wednesday, June 2nd'
        game_date = date.strftime("%A, %b #{date.day.ordinalize}")
        # Get time as '5:30PM'
        game_time = self.game.time.strftime("%l:%M%p").lstrip

        player_name = rsvp.responder.name

        rsvp.update(response: "yes")

        if (rsvp.game.rsvps.count { |rsvp| rsvp.response == 'yes' } >= rsvp.game.team.min_players)
          # SEND OUT TEXT TO MANAGER - MINIMUM PLAYERS
          @client.messages.create(
            from: @twilio_number,
            to: manager_phone,
            body: "You now have the minimum amount of players for your team, '#{team_name}', to play on #{game_date} at #{game_time}."
            )

        elsif (rsvp.game.rsvps.count { |rsvp| rsvp.response == 'yes' } >= rsvp.game.team.ideal_players)
          # SEND OUT TEXT TO MANAGER - FULL TEAM
          @client.messages.create(
            from: @twilio_number,
            to: manager_phone,
            body: "You now have the FULL amount of players for your team, '#{team_name}', to play on #{game_date} at #{game_time}."
            )
        end 

        response = Twilio::TwiML::Response.new do |r|
          r.Message "You have confirmed that you WILL be going to the game."
        end

        render :xml => response.to_xml

      elsif params['Body'].downcase == 'no'
        #set response to no

        if rsvp.response == 'yes'
          # SEND OUT TEXT TO MANAGER - PLAYER DROPPED OUT

          @client.messages.create(
            from: @twilio_number,
            to: manager_phone,
            body: "#{player_name} has DROPPED OUT of the game for your team, '#{team_name}', who are playing on #{game_date} at #{game_time}."
            )
        end

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

  # Configure Twilio
  def boot_twilio
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

end
