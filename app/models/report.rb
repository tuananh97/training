class Report < ApplicationRecord
  has_many :trainee_reports
  has_many :users, through: :trainee_reports

  attr_select = %i(id sender_id title description created_at)

  scope :trainee_reports, lambda{|id|
    select(attr_select).where(sender_id: id).order(created_at: :desc)
  }

  scope :trainer_reports, lambda{|id|
    joins(:trainee_reports).select(:id, :sender_id, :title, :description,
      :created_at, "trainee_reports.receiver_id as receiver_id")
                           .where("trainee_reports.receiver_id = #{id}")
                           .order(created_at: :desc)
  }
end
