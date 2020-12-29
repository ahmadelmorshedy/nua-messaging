class Inbox < ApplicationRecord

  belongs_to :user
  has_many :messages

  def update_unread_messages(value)
    update_column(:unread_count, self.unread_count + value)
  end
end