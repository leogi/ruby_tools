# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
