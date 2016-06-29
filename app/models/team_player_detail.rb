class TeamPlayerDetail < ActiveRecord::Base
  validates :key_position, inclusion: { in: [true, false] }
  validates :skill_level, presence: true

  belongs_to :team
  belongs_to :player
end
