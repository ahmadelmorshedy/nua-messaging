module MessageHelper
  def message_user_first_name(message, source)
    (source == 'Inbox')? message.outbox.user.first_name : message.inbox.user.first_name
  end

  def message_user_last_name(message, source)
    (source == 'Inbox')? message.outbox.user.last_name : message.inbox.user.last_name
  end
end
