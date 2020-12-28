# require 'minitest/autorun'
# require './app/models/application_record'
# require './app/models/message'
require 'test_helper'


class MessageTest < ActiveSupport::TestCase
  test '#message_created_has_unread_status' do
    user = users(:patient_hanks)
    doctor = users(:dr_smith)

    Message.create_message('test_message', doctor, user)

    assert Message.last.read == false
  end

  test '#message is saved in patient outbox' do
    p1 = users(:patient_hanks)
    p2 = users(:patient_cruz)
    d1 = users(:dr_smith)
    d2 = users(:dr_decaprio)

    Message.create_message('test message 1', d1, p1)
    Message.create_message('test message 2', d2, p2)

    assert p1.outbox.messages.last.body == 'test message 1'
    assert p2.outbox.messages.last.body == 'test message 2'
  end

  test '#message in response to new doctor messages is sent to dr inbox' do
    user = users(:patient_hanks)
    doctor = users(:dr_smith)

    Message.create_message('test_message', doctor, user)

    assert doctor.inbox.messages.last.body == 'test_message'
  end

  test '#message in response to old doctor messages is sent to dr inbox' do
    user = users(:patient_cruz)
    doctor = users(:dr_decaprio)
    admin = users(:admin_deniro)

    Message.create_message('test_message', doctor, user)

    assert doctor.inbox.messages.last.body != 'test_message'
    assert admin.inbox.messages.last.body == 'test_message'
  end
end
