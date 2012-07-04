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

question1 = Question.create(subject: questions[0][:subject], description: questions[0][:description], user_id: new_users[0].id)
question2 = Question.create(subject: questions[1][:subject], description: questions[1][:description], user_id: new_users[1].id)
question3 = Question.create(subject: questions[2][:subject], description: questions[2][:description], user_id: new_users[2].id)
question4 = Question.create(subject: questions[3][:subject], description: questions[3][:description], user_id: new_users[1].id)

answers = [{body: "add this to your canvas app's fb js"},
						{body: "Check your app settings and make sure you have set the Canvas Width to 'fluid' and Canvas Height to 'fixed' (Go to Settings > Advanced > Scroll to Canvas Settings.)"},
						{body: "There are various solutions you could try below. Please comment as to which one, or if none of them work and I will update this answer accordingly."}]

answer1 = Answer.create(question_id: question1.id, user_id: new_users[1].id,	body: answers[0][:body])	
answer2 = Answer.create(question_id: question1.id, user_id: new_users[2].id,	body: answers[1][:body])	
answer3 = Answer.create(question_id: question2.id, user_id: new_users[0].id,	body: answers[2][:body])	
answer4 = Answer.create(question_id: question2.id, user_id: new_users[2].id,	body: answers[1][:body])	
answer5 = Answer.create(question_id: question3.id, user_id: new_users[1].id,	body: answers[2][:body])	
answer6 = Answer.create(question_id: question3.id, user_id: new_users[0].id,	body: answers[0][:body])	
answer7 = Answer.create(question_id: question4.id, user_id: new_users[0].id,	body: answers[0][:body])	

Rating.create(:rateable_id => answer1.id, :rateable_type => "Answer", :rater => new_users[0], :rater_type => "User", :score => 1)						
Rating.create(:rateable_id => answer2.id, :rateable_type => "Answer", :rater => new_users[1], :rater_type => "User", :score => 1)						
Rating.create(:rateable_id => answer3.id, :rateable_type => "Answer", :rater => new_users[2], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => answer4.id, :rateable_type => "Answer", :rater => new_users[1], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => answer5.id, :rateable_type => "Answer", :rater => new_users[2], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => answer6.id, :rateable_type => "Answer", :rater => new_users[2], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => answer7.id, :rateable_type => "Answer", :rater => new_users[2], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => question1.id, :rateable_type => "Question", :rater => new_users[1], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => question2.id, :rateable_type => "Question", :rater => new_users[0], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => question3.id, :rateable_type => "Question", :rater => new_users[1], :rater_type => "User", :score => 1)
Rating.create(:rateable_id => question4.id, :rateable_type => "Question", :rater => new_users[2], :rater_type => "User", :score => 1)

tags = ['ruby', 'rails', 'js', 'javascript', 'jquery', 'css', 'html5', 'jquery-events', 'js-events']

tags.each do |tag|
  Tag.create(name: tag)
end
