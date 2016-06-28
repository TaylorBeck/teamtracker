class Game < ActiveRecord::Base
  validates :date, :location, presence: true

  belongs_to :team
end
