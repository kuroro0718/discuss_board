# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Hello World!"

create_account = User.create([email: 'test@gmail.com', password: '12345678', password_confirmation: '12345678', name: 'Test Account2'] )

puts "This seed will create an account automatically, and create 20 groups, each group has 30 posts"

create_groups = for i in 1..20 do
	Group.create!([title: "Gropu no.#{i}", description: "This is the #{i} discuss board created by seed", user_id: "3"])
	for k in 1..30 do
		Post.create!([group_id: "#{i}",content: "This is the #{k} post crated by seed", user_id: "3"])
	end
end