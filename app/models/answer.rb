class Answer < ActiveRecord::Base
  acts_as_rateable
  
  attr_accessible :user_id, :body, :rate, :question_id
  belongs_to :question
  belongs_to :user

  
end
