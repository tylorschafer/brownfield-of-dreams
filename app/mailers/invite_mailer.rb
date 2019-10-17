# frozen_string_literal: true

class InviteMailer < ApplicationMailer
  def invite_send(user, sender_name)
    @sender_name = sender_name
    @user = user
    mail(to: @user.email, subject: "#{sender_name} has sent you an Invitation")
  end
end
