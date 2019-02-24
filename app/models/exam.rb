class Exam < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  validates :title, presence: true
  accepts_nested_attributes_for :questions, allow_destroy: true
end
