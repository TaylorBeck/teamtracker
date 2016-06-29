class Rsvp < ActiveRecord::Base
  # Set default value of response to be 'not responded'
  before_save :default_values

  validates :responder, :game, :response, presence: true

  belongs_to :responder, class_name: "Player"
  belongs_to :game

  def default_values
    self.response ||= "not responded"
  end

  # Manager clicks button to send a reminder
  def send_reminder_manually
    boot_twilio

    player_phone = self.responder.phone_number
    date = self.game.date
    # Get date as 'Wednesday, June 2nd'
    game_date = date.strftime("%A, %b #{date.day.ordinalize}")
    # Get time as '5:30PM'
    game_time = self.game.time.strftime("%l:%M%p").lstrip
    team_name = self.game.team.name
    location = self.game.location

    # Send a text message to the player
    @client.messages.create(
      from: @twilio_number,
      to: player_phone,
      body: "You have a game on #{game_date} at #{game_time}. #{team_name} is playing at #{location}. Respond 'yes #{self.game.id}' or 'no #{self.game.id}' to let your coach know if you are going."
      )
  end

  # Automatic reminder texts sent out 7, 3, and 2 days before the game
  def send_reminder_automatically
    boot_twilio

    player_phone = self.responder.phone_number
    date = self.game.date
    # Get date as 'Wednesday, June 2nd'
    game_date = date.strftime("%A, %b #{date.day.ordinalize}")
    # Get time as '5:30PM'
    game_time = self.game.time.strftime("%l:%M%p").lstrip
    team_name = self.game.team.name
    location = self.game.location

    # Send a text message to the player
    @client.messages.create(
      from: @twilio_number,
      to: player_phone,
      body: "You have a game on #{game_date} at #{game_time}. #{team_name} is playing at #{location}. Respond 'yes #{self.game.id}' or 'no #{self.game.id}' to let your coach know if you are going."
      )
  end

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
        self.response = "yes"

        response = Twilio::TwiML::Response.new do |r|
          r.Message "You have confirmed that you WILL be going to the game."
        end

        render :xml => response.to_xml

      elsif params['Body'].downcase == 'no'
        #set response to no
        self.response = "no"

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

  # Create new delayed jobs to send reminders automatically
  handle_asynchronously :send_reminder_automatically, :run_at => Proc.new { self.game.date - 7.days }
  handle_asynchronously :send_reminder_automatically, :run_at => Proc.new { self.game.date - 3.days }
  handle_asynchronously :send_reminder_automatically, :run_at => Proc.new { self.game.date - 2.days }

  # Configure Twilio
  def boot_twilio
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

end
