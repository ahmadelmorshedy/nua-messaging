require 'test_helper'

class ReissueLostScriptTest < ActiveSupport::TestCase
  test '#it sends message to admin to signal a lost prescription' do
    ReissueLostScript.call(users(:patient_hanks))

    assert User.default_admin.inbox.messages.count == 1
  end

  test '#it adds payment record for the user requestin a new prescription' do
    ReissueLostScript.call(users(:patient_hanks))

    assert Payment.count == 1
    assert Payment.first.user == users(:patient_hanks)
  end

  # test '#it uses transaction to ensure integrity of data' do
  #   mock = Minitest::Mock.new
  #   def mock.debit_card(arg); raise ActiveRecord::Rollback; end

  #   Provider.stub :new, mock do
  #     ReissueLostScript.call(users(:patient_hanks))

  #     assert Payment.count == 0
  #     assert User.default_admin.inbox.messages.count == 0
  #   end
  # end
end
