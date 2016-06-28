class Team < ActiveRecord::Base
  validates :name, :ideal_players, :min_players, :min_females, presence: true

  has_many :team_player_details
  has_many :players, through: :team_player_details
  belongs_to :sport
  has_many :managers, foreign_key: :manager_id, class_name: :User
end
