# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

vince = User.create(
  first_name: "Vince",
  last_name: "Pimentel",
  username: "vince",
  email: "vince@pimentel.com",
  password: "123456",
  location: "California",
  website: "https://vincepimentel.com",
  instagram: "vinceinstagram",
  twitter: "vincetwitter",
  gender: "male",
  avatar: "https://avatars1.githubusercontent.com/u/343096?s=400&u=e72d7bf15402990dcfd0c259d0e4dfae51fc2c18&v=4",
  bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget metus eros. Duis pellentesque in odio eu lacinia. Etiam et elit non lorem semper vulputate. Curabitur justo augue, lacinia sed felis in, placerat feugiat arcu. Integer interdum tincidunt finibus. Maecenas et risus maximus, vestibulum lectus ut, viverra arcu."
  )

alice = User.create(
  first_name: "Alice",
  last_name: "Chan",
  username: "alice",
  email: "alice@chan.com",
  password: "123456",
  location: "California",
  website: "https://alicechan.com",
  instagram: "aliceinstagram",
  twitter: "alicetwitter",
  gender: "female",
  avatar: "http://i.imgur.com/HIBZF4m.jpg",
  bio: "In finibus dui eget iaculis pulvinar. Nam ac ipsum maximus quam aliquet vehicula vitae sit amet est. Maecenas semper lectus diam, non egestas orci tincidunt et. Integer mollis, massa nec efficitur tincidunt, augue ipsum dignissim elit, vel lobortis est diam eget tortor. Nam gravida, risus ullamcorper interdum euismod, nulla ligula semper erat, eu pharetra enim libero at enim. Nulla lacinia molestie libero. Nullam vel erat finibus, fermentum felis et, viverra nulla. Integer nisl orci, blandit non posuere ut, laoreet in nisi."
  )
