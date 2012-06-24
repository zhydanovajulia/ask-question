class Comment < ActiveRecord::Base
	belongs_to :answer
	belongs_to :user
  validates :body, :presence => true

  def author
    self.user.name
  end
end
