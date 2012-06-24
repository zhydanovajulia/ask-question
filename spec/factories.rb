FactoryGirl.define do

	factory :user do |f|
	  f.sequence(:name) { |n| "name_#{n}" }
	  f.sequence(:email) { |n| "login_#{n}@example.com" }
	  f.sequence(:password) { |n| "epyfnm" }
	  f.password_confirmation { |f| f.password }
	end

	factory :service do |f|
	  provider 'facebook'
	  f.sequence(:uname) { |n| "name_#{n}" }
	  f.sequence(:uemail) { |n| "login_#{n}@example.com" }
	  f.sequence(:uid) { |n| "#{n}" }
	end

	factory :question do |f|
		f.sequence(:subject) {|n| "subject #{n}"}
		f.sequence(:description) {|n| "description #{n}"}
		f.association :user
		f.rate 0
		f.watch_count 0
  end

  factory :answer do |f|
    f.sequence(:body) {|n| "answer#{n}"}
    f.association :user
    f .association :question
  end

	factory :question_rating,  class: Rating  do |f|
		f.association :rateable, factory: :question
		f.association :rater, factory: :user
		score 0
	end

	factory :answer_rating,  class: Rating  do |f|
		f.association :rateable, factory: :answer
		f.association :rater, factory: :user
		score 0
	end
end