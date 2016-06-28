class TeamPlayerDetail < ActiveRecord::Base
  #validates :key_position   #working on it
  validates :skill_level, presence: true

  belongs_to :team
  belongs_to :player
end
