class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  belongs_to :parent, class_name: Comment.name, optional: true,
    foreign_key: :parent_id
  has_many :replies, class_name: Comment.name, dependent: :destroy,
    foreign_key: :parent_id

  validates :content, presence: true, length: {minimum: Settings.comment.min_length,
    maximum: Settings.comment.max_length}

  def parent?
    self.parent.nil?
  end

  def new_reply
    self.replies.build task_id: self.task_id
  end
end
