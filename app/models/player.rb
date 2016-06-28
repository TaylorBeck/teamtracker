class Player < ActiveRecord::Base
  validates :name, :gender, :phone_number, presence: true

end
