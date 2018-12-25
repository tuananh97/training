class Report < ApplicationRecord
  has_many :trainee_reports
  has_many :users, through: :trainee_reports

  scope :trainee_reports, ->(id){select(:id, :sender_id, :title, :description, :created_at).where(sender_id: id).order created_at: :desc}
  scope :trainer_reports, (lambda do |id|
    joins(:trainee_reports).select(:id, :sender_id, :title, :description, "trainee_reports.receiver_id as receiver_id", :created_at)
      .where("trainee_reports.receiver_id = #{id}").order created_at: :desc
  end)
end
