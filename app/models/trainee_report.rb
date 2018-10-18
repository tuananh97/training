class TraineeReport < ApplicationRecord
  belongs_to :user, foreign_key: :receiver_id
  belongs_to :report
end
