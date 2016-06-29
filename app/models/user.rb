class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :teams, foreign_key: :manager_id
  has_many :games, through: :teams
end
