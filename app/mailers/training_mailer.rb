class TrainingMailer < ApplicationMailer
  default from: ENV["MAIL_DEFAULT"]

  def assign_to_course user, course
    @user = user
    @course = course
    mail to: @user.email, subject: t("mailer.assign_to_course",
      name: @course.name)
  end

  def remove_from_course user, course
    @user = user
    @course = course
    mail to: @user.email, subject: t("mailer.remove_from_course",
      name: @course.name)
  end

  def mail_month course
    @supervisor = course.supervisor
    mail to: @supervisor.email, subject: t("mailer.mail_month")
  end
end
