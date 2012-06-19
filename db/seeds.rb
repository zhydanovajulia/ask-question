# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [{email: 'john@john.com', password: 'epyfnm', name: 'John Doe'},
				 {email: 'angelina@an.com', password: 'epyfnm', name: 'Angelina Joly'},
				 {email: 'r2d2@r2d2.com', password: 'epyfnm', name: 'R2D2'}]

new_users = User.create users

questions = [{subject: "Why can't I connect to an NNTP server?", description: "user enable/disable rotation"},
 {subject: "SQL QUERY Result arrangement issue", description: "This is my Sql query select name,description from wp_widget_custom where name in ('hemel-hempstead','maidenhead','guildford','bromley','east-london','hertfordshire','billericay','surrey')"},
 {subject: "Alternate Row Colors in Html Tables Using Django", description: "How does one alternate row colors in a table in django that's generated using a for loop from a list? In asp.net it is possible to do math on the view to easily calculate that, but from what I"},
{subject: "user enable/disable rotation", description: "I want to allow the interface to change only if the flag enableRotation=1. I been messing around with all the rotation methods and am getting nowhere"}]

new_questions = []
questions.each do |question|
	new_questions << Question.create(subject: question[:subject], description: question[:description], user_id: new_users.map(&:id).map(&:to_i).sample)
end

answers = [{body: "add this to your canvas app's fb js"},
						{body: "Check your app settings and make sure you have set the Canvas Width to 'fluid' and Canvas Height to 'fixed' (Go to Settings > Advanced > Scroll to Canvas Settings.)"},
						{body: "There are various solutions you could try below. Please comment as to which one, or if none of them work and I will update this answer accordingly."}]

new_answers = []
answers.each do |answer|
	new_answers << Answer.create(question_id: new_questions.map(&:id).map(&:to_i).sample,
								user_id: new_users.map(&:id).map(&:to_i).sample,
								body: answer[:body])	
end						