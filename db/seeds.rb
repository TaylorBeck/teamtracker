require 'faker'

User.delete_all
Teams.delete_all
Players.delete_all


User.create(name: 'Gary', phone_number: '123-456-7890', email: 'email@gmail.com', password: 'pass')

Teams.create(name: 'Garys Gallupers', sport: 'Volleyball', ideal_players: 6, min_players: 4, min_females: 2, manager_id: 1)

Players.create(name: 'Joe', gender: 'm', phone_number: '122-344-5678', email: 'email@gmail.com')

# Sports.create(name: 'Volleyball', player_id: 1, skill_level: 2, manager_id: 1)