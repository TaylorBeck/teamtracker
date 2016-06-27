class Team < ActiveRecord::Base
  validates :name, :sport, :min_players, :ideal_players, :min_females, presence: true
end
