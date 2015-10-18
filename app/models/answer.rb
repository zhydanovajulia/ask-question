class Answer < ActiveRecord::Base
  acts_as_rateable
  
  # attr_accessible :user_id, :body, :rate, :question_id
  validates :body, :presence => true

  belongs_to :question
  belongs_to :user
  belongs_to :author, :class_name => "User"
  has_many :comments

  def author
  	self.user
  end
  
end
