class Answer < ActiveRecord::Base
  attr_accessible :author, :body, :rate
  belongs_to :question
  belongs_to :user
end
