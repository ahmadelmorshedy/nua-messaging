class Message < ApplicationRecord

  belongs_to :inbox
  belongs_to :outbox

  def self.get_original_message(user)
    user.inbox.messages.first
  end

  def self.create_message(body, receiver, sender)
    message = Message.new(body: body, outbox_id: sender.outbox.id)
    if Message.get_original_message(sender).try(:created_at) >= Date.today - 7.days
      inbox = User.default_doctor.inbox
    else
      inbox = User.default_admin.inbox
    end
    message.inbox_id = inbox.id

    message.save!
  end
end