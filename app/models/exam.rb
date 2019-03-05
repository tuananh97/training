class Exam < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  belongs_to :subject

  validates :title, presence: true
  scope :by_lastest, ->{order(created_at: :desc)}
end
