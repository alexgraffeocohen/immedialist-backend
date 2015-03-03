
die_hard = Movie.create(name: "Die Hard")
the_hobbit = Book.create(name: "The Hobbit")
reflektor = Album.create(name: "Reflektor")

ListItem.create([
  { name: "Die Hard", item: die_hard  },
  { name: "The Hobbit", item: the_hobbit },
  { name: "Reflektor", item: reflektor }
])
