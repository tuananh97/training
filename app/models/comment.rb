class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  belongs_to :parent, class_name: Comment.name, optional: true,
    foreign_key: :parent_id
  has_many :replies, class_name: Comment.name, dependent: :destroy,
    foreign_key: :parent_id

  validates :content, presence: true

  def parent?
    parent.nil?
  end

  def new_reply
    replies.build task_id: task_id
  end
end
