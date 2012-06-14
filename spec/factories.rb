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
end