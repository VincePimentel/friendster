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
  email: "vince_pimentel@email.com",
  password: "123456",
  password_confirmation: "123456",
  location: "California",
  website: "https://vincepimentel.com",
  instagram: "vinceinstagram",
  twitter: "vincetwitter",
  gender: "male",
  bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget metus eros. Duis pellentesque in odio eu lacinia. Etiam et elit non lorem semper vulputate. Curabitur justo augue, lacinia sed felis in, placerat feugiat arcu. Integer interdum tincidunt finibus. Maecenas et risus maximus, vestibulum lectus ut, viverra arcu."
  )

vince.update(avatar: "#{vince.gravatar_url}&d=robohash&size=175")

alice = User.create(
  first_name: "Alice",
  last_name: "Chan",
  username: "alice",
  email: "alice_chan@email.com",
  password: "123456",
  password_confirmation: "123456",
  location: "California",
  website: "https://alicechan.com",
  instagram: "aliceinstagram",
  twitter: "alicetwitter",
  gender: "female",
  bio: "In finibus dui eget iaculis pulvinar. Nam ac ipsum maximus quam aliquet vehicula vitae sit amet est. Maecenas semper lectus diam, non egestas orci tincidunt et. Integer mollis, massa nec efficitur tincidunt, augue ipsum dignissim elit, vel lobortis est diam eget tortor. Nam gravida, risus ullamcorper interdum euismod, nulla ligula semper erat, eu pharetra enim libero at enim. Nulla lacinia molestie libero. Nullam vel erat finibus, fermentum felis et, viverra nulla. Integer nisl orci, blandit non posuere ut, laoreet in nisi."
  )

alice.update(avatar: "#{alice.gravatar_url}&d=robohash&size=175")

people = [
  ["Pat Wolfe", "male"],
  ["Darren Stewart", "male"],
  ["Nettie Fields", "female"],
  ["Joseph Osborne", "male"],
  ["Willie Craig", "male"],
  ["Sylvester Herrera", "male"],
  ["Erma Willis", "female"],
  ["Nelson Fuller", "male"],
  ["Kelly Hamilton", "female"],
  ["Rachael Quinn", "female"],
]

people.each do |person|
  full_name = person[0]
  first = full_name.split[0]
  last = full_name.split[1]
  join = first.downcase + last.downcase
  email = "#{first.downcase}_#{last.downcase}@email.com"

  user = User.create(
    first_name: first,
    last_name: last,
    username: join,
    email: email,
    password: "123456",
    password_confirmation: "123456",
    location: "California",
    website: "https://#{join}.com",
    instagram: "#{join}instagram",
    twitter: "#{join}twitter",
    gender: person[1],
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget metus eros. Duis pellentesque in odio eu lacinia. Etiam et elit non lorem semper vulputate. Curabitur justo augue, lacinia sed felis in, placerat feugiat arcu. Integer interdum tincidunt finibus. Maecenas et risus maximus, vestibulum lectus ut, viverra arcu."
    )

  user.update(avatar: "#{user.gravatar_url}&d=robohash&size=175")

  next if %w[Kelly Rachael Erma Nelson Willie].include?(user.first_name)

  user_friendship = user.friendships.build(friend_id: vince.id)

  user_friendship.save
end


