class Message < ApplicationRecord

  belongs_to :inbox
  belongs_to :outbox

  after_create :increment_inbox_unread

  def self.get_original_message(user)
    user.inbox.messages.first
  end

  def self.create_message(body, receiver, sender)
    message = Message.new(body: body, outbox_id: sender.outbox.id)
    receiver = User.default_admin if Message.get_original_message(sender).try(:created_at) < Date.today - 7.days

    message.inbox_id = receiver.inbox.id

    message.save!
  end

  def mark_as_read
    unless read
      update_column(:read, true)
      inbox.update_unread_messages(-1)
    end
  end

  def mark_as_read
    unless read
      update_column(:read, true)
      inbox.update_unread_messages(-1)
    end
  end

  private
  def increment_inbox_unread
    inbox.update_unread_messages(1)
  end
end