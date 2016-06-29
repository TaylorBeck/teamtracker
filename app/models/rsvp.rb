class Rsvp < ActiveRecord::Base
  validates :responder, :game, :response, presence: true

  belongs_to :responder, class_name: "Player"
  belongs_to :game

end
