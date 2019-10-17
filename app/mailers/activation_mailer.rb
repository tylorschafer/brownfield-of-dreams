# frozen_string_literal: true

class ActivationMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Activate your account')
  end
end
