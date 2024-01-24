# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  subscription           :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @unique_email = "romanch#{rand(1000..9999)}@gmail.com"
  end
  test 'should not save user without email' do
    user = User.new
    assert_not user.save, 'Saved the user without email'
  end

  test 'should not save user with invalid email' do
    user = User.new(email: 'test', password: '1234567890', password_confirmation: '1234567890', admin: false)
    assert_not user.save, 'Saved the user with invalid email'
  end

  test 'should save user with valid email' do
    user = User.new(email: @unique_email, password: '123456', password_confirmation: '123456', admin: false)
    assert user.save, 'Saved the user with valid email'
  end

  test 'should not save user with duplicate email' do
    user1 = users(:one)
    user1.password = '1234567890'
    user1.password_confirmation = '1234567890'
    user2 = User.new(email: 'romanch@gmail.com', password: '1234567890', password_confirmation: '1234567890',
                     admin: false)
    assert user1.save, 'Saved the user with valid email'
    assert_not user2.save, 'Saved the user with duplicate email'
  end

  test 'should not save user without password' do
    user = User.new(email: @unique_email, admin: false)
    assert_not user.save, 'Saved the user without password'
  end

  test 'should not save user with password less than 6 characters' do
    user = User.new(email: @unique_email, password: '12345', admin: false)
    assert_not user.save, 'Saved the user with password less than 6 characters'
  end

  test 'should not save user with password more than 128 characters' do
    user = User.new(email: @unique_email,
                    password: '123456789012345678901234567890
                                       123456789012345678901234567890123
                                       456789012345678901234567890',
                    admin: false)
    assert_not user.save, 'Saved the user with password more than 128 characters'
  end

  test 'should not save user with password confirmation mismatch' do
    user = User.new(email: @unique_email, password: '1234567890', password_confirmation: '123456789', admin: false)
    assert_not user.save, 'Saved the user with password confirmation mismatch'
  end

  test 'should save user with password confirmation match' do
    user = User.new(email: @unique_email, password: '1234567890', password_confirmation: '1234567890', admin: false)
    puts user.errors.full_messages unless user.save
    assert user.save, 'Saved the user with password confirmation match'
  end

  test 'should not save user with password confirmation nil' do
    user = User.new(email: @unique_email, password: '1234567890', password_confirmation: nil, admin: false)
    assert_not user.save, 'Saved the user with password confirmation nil'
  end

  test 'should not save user with password nil' do
    user = User.new(email: @unique_email, password: nil, password_confirmation: '1234567890', admin: false)
    assert_not user.save, 'Saved the user with password nil'
  end

  test 'should not save user without admin flag' do
    user = User.new(email: @unique_email, password: '1234567890', password_confirmation: '1234567890')
    user.admin = nil
    assert_not user.save, 'Saved the user without admin flag'
  end

  test 'check_subscription should update admin attribute based on subscription status' do
    # Create a new user with a subscription status of true
    user = User.new(email: @unique_email, password: '1234567890', password_confirmation: '1234567890')
    assert user.save, 'Failed to save the user with subscription and admin status is not passed as an argument'

    user.subscription = true, 'Failed to update the subscription status of the user to true'
    assert user.save, 'Failed to save the user with subscription status true'

    # Assert that the admin attribute of the user is true
    assert_equal true, user.admin, 'Admin attribute is not true when subscription status is true'

    # Update the subscription status of the user to false and save the user
    user.subscription = false
    assert user.save, 'Failed to save the user with subscription status false'

    # Assert that the admin attribute of the user is false
    assert_equal false, user.admin, 'Admin attribute is not false when subscription is expired'
  end
end
