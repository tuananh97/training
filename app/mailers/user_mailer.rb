class UserMailer < ApplicationMailer
  def send_invite_instructions user
    @user = user
    mail to: @user.email, subject: t("user.mailer.invite_user")
  end
end
