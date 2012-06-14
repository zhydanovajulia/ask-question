When /^I try to sign up with "(.*)"$/ do |email|
	visit(new_user_registration_path)
  fill_in('user_email', :with => email)
  fill_in('user_password', :with => 's3cr3t')
  fill_in('user_password_confirmation', :with => 's3cr3t')
  click_button('Sign up')
end

When /^I sign in as user with "(.*?)"$/ do |email|
  visit(new_user_session_path)
  fill_in('user_email', :with => email)
  fill_in('user_password', :with => 'epyfnm')
  click_button('Sign in')
end


