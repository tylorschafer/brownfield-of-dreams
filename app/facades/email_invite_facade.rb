class EmailInviteFacade
  attr_reader :sender_name, :recipient_name

  def initialize(sender_name, recipient_name)
    @sender_name = sender_name
    @recipient_name = recipient_name
  end
end
