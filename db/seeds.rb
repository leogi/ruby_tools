# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if !User.any?
  Role.delete_all
  User.delete_all
  UserRole.delete_all
  
  puts "Create roles"
  %w(admin user).each do |role|
    Role.create(name: role)
  end
  puts "Create admin users"
  user = User.create(email: "nghialv.bk@gmail.com", 
                     encrypted_password: "$2a$10$GK8FtiIgjw9g3562ttIqJO4j6BVZ.wAguk4KDP3/eBqi.aVHZZYK6")
  UserRole.create(user_id: user.id, role_id: Role.where(name: "admin").first.id)
end

Story.delete_all
Vocabulary.delete_all
Comment.delete_all

story = Story::Origin.create(title: "Teachers'  Day",
                     content: "One day every year, we celebrate Teachers' Day in honour of the teachers who spend so much time teaching us so many things.
This year, Teachers' Day began with a school assembly in the hall where the headmaster delivered a speech. After that we adjourned to our classes, not to have lessons, but to enjoy ourselves.

My classmates gave a small party for the teachers who taught us. Each of us contributed a small sum of money to buy cakes, drinks and other titbits. On that day we arranged the chairs and desks so that they surrounded an empty space in the middle of the classroom.

So began a round of eating, drinking and playing games with the teachers. Most of the teachers were very sporting and we thoroughly enjoyed ourselves. It was so different from having lessons.

The other classes gave parties too. So the teachers had to move from class to class and participate in the fun. I would think that this was quite tiring on the part of the teachers but they managed it. After all it was their day to enjoy and have fun.

One class even gave a short play for their teachers. I did not get to watch it as I was busy tidying up the classroom after the party.

All in all it was a great day. The whole school was immersed in an atmosphere of gaiety. So when the school bell rang for dismissal I felt a little sad that it should end, but end it must. The day was over and we went home tired but happy.")

story.translations.create(title: "Teachers'  Day",
                          content: "One day every year, we celebrate Teachers' Day in honour of the teachers who spend so much time teaching us so many things.
This year, Teachers' Day began with a school assembly in the hall where the headmaster delivered a speech. After that we adjourned to our classes, not to have lessons, but to enjoy ourselves.

My classmates gave a small party for the teachers who taught us. Each of us contributed a small sum of money to buy cakes, drinks and other titbits. On that day we arranged the chairs and desks so that they surrounded an empty space in the middle of the classroom.

So began a round of eating, drinking and playing games with the teachers. Most of the teachers were very sporting and we thoroughly enjoyed ourselves. It was so different from having lessons.

The other classes gave parties too. So the teachers had to move from class to class and participate in the fun. I would think that this was quite tiring on the part of the teachers but they managed it. After all it was their day to enjoy and have fun.

One class even gave a short play for their teachers. I did not get to watch it as I was busy tidying up the classroom after the party.

All in all it was a great day. The whole school was immersed in an atmosphere of gaiety. So when the school bell rang for dismissal I felt a little sad that it should end, but end it must. The day was over and we went home tired but happy.")

story.vocabularies.create(keyword: "adjourn to somewhere", explain: "to finish doing something and go somewhere, usually for a drink and some food")
story.vocabularies.create(keyword: "titbit/tidbit", explain: "a small piece of interesting information, or a small item of pleasant-tasting food")
story.vocabularies.create(keyword: "immerse", explain: "to become completely involved in something")
