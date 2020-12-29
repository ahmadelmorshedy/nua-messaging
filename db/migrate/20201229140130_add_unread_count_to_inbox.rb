class AddUnreadCountToInbox < ActiveRecord::Migration[5.0]
  def change
    add_column :inboxes, :unread_count, :integer, default: 0
  end
end
