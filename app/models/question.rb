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

  def sorted_answers
    Answer.select('answers.*, count(rateable_id) as ratings_count').
                where("`answers`.`question_id` = ? OR `answers`.`question_id` = null", self.id).
                where("rateable_type = 'Answer'").
                joins('LEFT JOIN ratings ON answers.id = rateable_id').
                group('answers.id').order('count(rateable_id) DESC')
  end
end
