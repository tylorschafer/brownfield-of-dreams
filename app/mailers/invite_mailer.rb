class InviteMailer < ApplicationMailer

  def invite_send(email, sender_name, recipient_name)
    @sender_name = sender_name
    @recipient_name = recipient_name
    mail(to: email, subject: "#{sender_name} has sent you an Invitation")
  end
end
