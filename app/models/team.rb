class Team < ActiveRecord::Base
  has_many

  validates :name, :sport, :min_players, :ideal_players, :min_females, presence: true
end
