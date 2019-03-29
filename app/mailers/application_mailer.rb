# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfieldofdreams.io'
  layout 'mailer'
end
