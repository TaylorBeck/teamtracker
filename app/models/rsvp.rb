class Rsvp < ActiveRecord::Base
  # Set default value of response to be 'not responded'
  before_save :default_values

  after_save :send_reminder_automatically

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
