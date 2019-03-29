# frozen_string_literal: true

# Application Mailer to send emails
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfieldofdreams.io'
  layout 'mailer'
end
