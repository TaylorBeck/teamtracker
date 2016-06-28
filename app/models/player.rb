class Player < ActiveRecord::Base
  validates :name, :gender, :phone_number, presence: true

  has_many :team_player_details
  has_many :teams, through: :team_player_details
end
