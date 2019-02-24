class Result < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :question
  belongs_to :test
end
