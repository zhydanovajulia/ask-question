class Question < ActiveRecord::Base
  acts_as_rateable

  attr_accessible :subject, :description, :user_id, :rate, :answers_count
  validates :subject, :presence => true
  belongs_to :user
  has_many :answers

  
  
  def author
  	self.user
  end
end
