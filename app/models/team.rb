class Team < ActiveRecord::Base
  validates :name, :sport_id, :min_players, :ideal_players, :min_females, presence: true
end
