class Question < ActiveRecord::Base
  acts_as_rateable

  validates :subject, :presence => true
  belongs_to :user
  has_many :answers
  has_many :tags, :through => :taggings
  has_many :taggings
  attr_accessible :subject, :description, :watch_count, :user_id, :tag_list

  self.per_page = 4

  def tag_list= tags
    tags = tags.to_s.split(',') if tags.is_a?(String) or tags.nil?
    list_of_new_tags(tags).each do |tag_name|
      self.tags.create(:name => tag_name)
    end
    removed_tags = self.tag_ids - existing_tags(tags).map(&:id)
    self.taggings.where(:tag_id => removed_tags).destroy_all
    self.tag_ids = existing_tags(tags).map(&:id)
  end

  def self.build_with_tags options
    list_of_tags = options.delete(:tag_list)
    question = Question.create(options)
    if question.save
      question.tag_list = list_of_tags
      return question
    end
    false
  end

  def tag_list
    self.tags.map(&:name)
  end

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

  def answers_without_rating
    Answer.joins('LEFT JOIN ratings ON answers.id = rateable_id').
            where("`answers`.`question_id` = ?", self.id).
            where('score IS NULL').
            order('answers.created_at DESC')
  end

  def all_answers
    sorted_answers + answers_without_rating
  end

  private

  def list_of_new_tags tags
    parsed_tags(tags) - existing_tags(tags).map(&:name)
  end

  def existing_tags tags
    Tag.where(:name => parsed_tags(tags))
  end

  def parsed_tags tags
    tags.map(&:strip)
  end

end
