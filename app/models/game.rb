class Game < ActiveRecord::Base
  validates :date, :location, presence: true

  belongs_to :team
  has_many :rsvps, dependent: :destroy
  has_many :players, through: :team
end
