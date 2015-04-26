
die_hard = Movie.create(name: "Die Hard")
the_hobbit = Book.create(name: "The Hobbit")
reflektor = Album.create(name: "Reflektor")
lucky_you = Song.create(name: "Lucky You")
brad_pitt = Creator.create(name: "Brad Pitt")
lost = Show.create(name: "Lost")

ListItem.create([
  { name: "Die Hard", item: die_hard  },
  { name: "The Hobbit", item: the_hobbit },
  { name: "Reflektor", item: reflektor },
  { name: "Lucky You", item: lucky_you },
  { name: "Brad Pitt", item: brad_pitt },
  { name: "Lost", item: lost }
])
