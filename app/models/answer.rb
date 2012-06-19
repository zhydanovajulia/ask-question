class Answer < ActiveRecord::Base
  attr_accessible :user_id, :body, :rate, :question_id
  belongs_to :question
  belongs_to :user
end
