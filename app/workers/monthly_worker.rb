class MonthlyWorker
  include Sidekiq::Worker

  MAIL_MONTH = 1

  def perform action
    case action
    when MAIL_MONTH
      Course.all.each do |course|
        send_email_when_end_month course
      end
    end
  end

  private

  def send_email_when_end_month course
    TrainingMailer.mail_month(course).deliver_now
  end
end
