Game.delete_all
User.delete_all
Team.delete_all
Player.delete_all
Sport.delete_all


User.create(name: 'Gary', phone_number: '123-456-7890', email: 'email@gmail.com', password: 'pass')


t1 = Team.create(name: "Gary's Gilligans", sport_id: 1, ideal_players: 6, min_players: 4, min_females: 2, manager_id: 1)
t2 = Team.create(name: "Gary's Gophers", sport_id: 1, ideal_players: 4, min_players: 2, min_females: 1, manager_id: 1)

Game.create(team: t1, date: DateTime.now, time: DateTime.now, location: 'North Clairemont Rec Center')
Game.create(team: t2, date: DateTime.now, time: DateTime.now, location: 'South Clairemont Rec Center')



Player.create(name: 'Joe', gender: 'm', phone_number: '122-344-5678')
Player.create(name: 'Jane', gender: 'f', phone_number: '999-111-2222')
Player.create(name: 'Mary', gender: 'f', phone_number: '858-123-4567')
Player.create(name: 'Fred', gender: 'm', phone_number: '619-765-4321')


Sport.create(name: 'Volleyball')
Sport.create(name: 'Basketball')
Sport.create(name: 'Soccer')
Sport.create(name: 'Softball')
