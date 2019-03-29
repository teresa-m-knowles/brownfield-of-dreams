# frozen_string_literal: true

# Application Mailer to invite people to the app
class InviteMailer < ApplicationMailer
  def invite(user, github_user)
    @user = user
    @github_user = github_user
    message = 'wants to invite you to Brownfield of Dreams.'
    mail(
      to: @github_user.email,
      subject: "#{@user.first_name} #{message}"
    )
  end
end
