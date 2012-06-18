class Question < ActiveRecord::Base
  attr_accessible :subject, :description, :author, :rate

  belongs_to :user
  has_many :answers
end
