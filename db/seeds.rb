# reset seeds
Game.delete_all
User.delete_all
Team.delete_all
Player.delete_all
Sport.delete_all

# create Gary as user
gary = User.create(name: 'Gary', phone_number: '123-456-7890', email: 'email@gmail.com', password: 'pass')

# create sports
volleyball = Sport.create(name: 'Volleyball')
basketball = Sport.create(name: 'Basketball')
soccer = Sport.create(name: 'Soccer')
softball = Sport.create(name: 'Softball')

# create teams
team1 = Team.create(name: "Gary's Gilligans", sport: soccer, ideal_players: 5, min_players: 4, min_females: 2, manager: gary)
team2 = Team.create(name: "Gary's Gophers", sport: volleyball, ideal_players: 4, min_players: 2, min_females: 1, manager: gary)
team3 = Team.create(name: "Gary's Giraffes", sport: basketball, ideal_players: 5, min_players: 3, min_females: 2, manager: gary)
team4 = Team.create(name: "Gary's Geese", sport: softball, ideal_players: 8, min_players: 6, min_females: 1, manager: gary)
team5 = Team.create(name: "Gary's Gazelles", sport: soccer, ideal_players: 8, min_players: 6, min_females: 2, manager: gary)
team6 = Team.create(name: "Gary's Gorillas", sport: volleyball, ideal_players: 8, min_players: 6, min_females: 1, manager: gary)

# create games
game1 = Game.create(team: team1, date: DateTime.now+1, time: DateTime.now, location: 'North Clairemont Rec Center')
game2 = Game.create(team: team2, date: DateTime.now+2, time: DateTime.now, location: 'Golden Hill Rec Center')
game3 = Game.create(team: team3, date: DateTime.now+2, time: DateTime.now, location: 'North Park Rec Center')
game4 = Game.create(team: team3, date: DateTime.now+3, time: DateTime.now, location: 'West Clairemont Rec Center')
game5 = Game.create(team: team4, date: DateTime.now+4, time: DateTime.now, location: 'Hillcrest Rec Center')
game6 = Game.create(team: team5, date: DateTime.now+5, time: DateTime.now, location: 'Mission Valley Rec Center')
game7 = Game.create(team: team6, date: DateTime.now+6, time: DateTime.now, location: 'East Clairemont Rec Center')
game8 = Game.create(team: team4, date: DateTime.now+7, time: DateTime.now, location: 'Golden Hill Rec Center')

# create players
mike = Player.create(name: 'Mike', gender: 'm', phone_number: '619-944-8738')
elliot = Player.create(name: 'Elliot', gender: 'm', phone_number: '555-555-2832')
mandy = Player.create(name: 'Mandy', gender: 'f', phone_number: '909-974-8030')
martha = Player.create(name: 'Martha', gender: 'f', phone_number: '555-555-7890')
taylor = Player.create(name: 'Taylor', gender: 'm', phone_number: '858-336-2522')
joe = Player.create(name: 'Joe', gender: 'm', phone_number: '555-555-5678')
jane = Player.create(name: 'Jane', gender: 'f', phone_number: '555-555-2222')
mary = Player.create(name: 'Mary', gender: 'f', phone_number: '555-555-4567')
fred = Player.create(name: 'Fred', gender: 'm', phone_number: '555-555-4321')

# add players to teams (create team-player-details)
joeteam1 = TeamPlayerDetail.create(key_position: false, skill_level: 5, player: joe, team: team1)
janeteam1 = TeamPlayerDetail.create(key_position: false, skill_level: 10, player: jane, team: team1)
miketeam1 = TeamPlayerDetail.create(key_position: true, skill_level: 5, player: mike, team: team1)
elliotteam1 = TeamPlayerDetail.create(key_position: false, skill_level: 10, player: elliot, team: team1)
mandyteam1 = TeamPlayerDetail.create(key_position: true, skill_level: 7, player: mandy, team: team1)

maryteam2 = TeamPlayerDetail.create(key_position: true, skill_level: 7, player: mary, team: team2)
fredteam2 = TeamPlayerDetail.create(key_position: false, skill_level: 2, player: fred, team: team2)
marthateam2 = TeamPlayerDetail.create(key_position: false, skill_level: 2, player: martha, team: team2)
taylorteam2 = TeamPlayerDetail.create(key_position: false, skill_level: 2, player: taylor, team: team2)

joeteam3 = TeamPlayerDetail.create(key_position: false, skill_level: 5, player: joe, team: team3)
janeteam3 = TeamPlayerDetail.create(key_position: false, skill_level: 10, player: jane, team: team3)
miketeam3 = TeamPlayerDetail.create(key_position: false, skill_level: 5, player: mike, team: team3)
elliotteam3 = TeamPlayerDetail.create(key_position: false, skill_level: 10, player: elliot, team: team3)
mandyteam3 = TeamPlayerDetail.create(key_position: true, skill_level: 7, player: mandy, team: team3)

# create rsvps
rsvp1 = Rsvp.create(responder: joe, game: game1, response: "yes")
rsvp2 = Rsvp.create(responder: jane, game: game1, response: "no")
rsvp3 = Rsvp.create(responder: mike, game: game1, response: "yes")
rsvp4 = Rsvp.create(responder: mandy, game: game1, response: "yes")
rsvp5 = Rsvp.create(responder: elliot, game: game1, response: "none")

rsvp6 = Rsvp.create(responder: martha, game: game2, response: "no")
rsvp7 = Rsvp.create(responder: taylor, game: game2, response: "yes")
rsvp8 = Rsvp.create(responder: mary, game: game2, response: "none")
rsvp9 = Rsvp.create(responder: fred, game: game2, response: "yes")

rsvp10 = Rsvp.create(responder: joe, game: game3, response: "yes")
rsvp11 = Rsvp.create(responder: jane, game: game3, response: "yes")
rsvp12 = Rsvp.create(responder: mike, game: game3, response: "yes")
rsvp13 = Rsvp.create(responder: mandy, game: game3, response: "yes")
rsvp14 = Rsvp.create(responder: elliot, game: game3, response: "yes")