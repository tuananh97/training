class Notification < ApplicationRecord
  after_create_commit {NotificationBroadcastJob.perform_later(Notification.count, self)}
  belongs_to :course
end
