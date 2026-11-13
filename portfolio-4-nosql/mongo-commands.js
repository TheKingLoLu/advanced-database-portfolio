arenarank
db.players.insertOne({ _id: 1, username: "player1", country: "NG", profile: { avatar: "knight.png", bio: "Speed runner" }, achievements: [ { name: "First Win", game: "Space Raiders" }, { name: "100 Points", game: "Puzzle Quest" } ], recent_scores: [ { game: "Space Raiders", points: 5000 } ] })
db.players.insertOne({ _id: 2, username: "player2", country: "GH", profile: { avatar: "wizard.png" }, achievements: [], recent_scores: [] })
db.players.find({ country: "NG" })
db.players.updateOne({ _id: 1 }, { $push: { achievements: { name: "Top 10", game: "Space Raiders" } } })
db.players.find({ "achievements.name": "Top 10" })
db.players.createIndex({ country: 1 })