class TeamPlayerDetail < ActiveRecord::Base
  validates :key_position, presence: true
  validates :skill_level, presence: true

  belongs_to :team
  belongs_to :player
end
