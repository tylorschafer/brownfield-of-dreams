# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@tylorandkellysapp.com'
  layout 'mailer'
end
