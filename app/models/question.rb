class Question < ActiveRecord::Base
  acts_as_rateable

  validates :subject, :presence => true
  belongs_to :user
  has_many :answers

  def author
  	self.user
  end

  def has_respond user
  	self.answers.where(:user => user)
  end
end
