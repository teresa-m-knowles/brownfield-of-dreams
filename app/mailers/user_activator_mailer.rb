# frozen_string_literal: true

# Sends an email upon user registration
class UserActivatorMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "You're almost there!")
  end
end
