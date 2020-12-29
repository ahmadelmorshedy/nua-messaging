require './app/lib/payment_provider_factory'
class ReissueLostScript
  def self.call(*args, &block)
    new(*args, &block).execute
  end

  def initialize(user)
    @user = user
  end

  def execute
    ActiveRecord::Base.transaction do
      # create hardcoded message to the admin
      Message.new(body: 'Please re-Issue my Lost prescription',
                  inbox_id: User.default_admin.inbox.id,
                  outbox_id: @user.outbox.id).save!

      # Api Request to payment
      PaymentProviderFactory.provider.debit_card(@user)

      # Create a new Payment record
      Payment.new(user_id: @user.id).save!
    end
  end
end