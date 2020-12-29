namespace :inboxes do
  desc 'Initialize unread messages count'
  # example run: RAILS_ENV=development bundle exec rake inboxes:initialize_unread_messages_count
  task :initialize_unread_messages_count => :environment do
    Inbox.all.find_in_batches do |inboxes_batch|
      inboxes_batch.each do |inbox|
        inbox.update_column(:unread_count, inbox.messages.where(read: false).count)
      end
    end
  end
end