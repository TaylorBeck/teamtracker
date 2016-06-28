class Game < ActiveRecord::Base
  validates :date_time, :location, presence: true

  belongs_to :team
end
