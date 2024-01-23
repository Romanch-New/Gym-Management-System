# == Schema Information
#
# Table name: business_users
#
#  id          :bigint           not null, primary key
#  role        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_business_users_on_business_id              (business_id)
#  index_business_users_on_business_id_and_user_id  (business_id,user_id) UNIQUE
#  index_business_users_on_user_id                  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class BusinessUserTest < ActiveSupport::TestCase
  fixtures :business_users, :businesses, :users

  test 'should not save business user without user' do
    business_user = BusinessUser.new
    assert_not business_user.valid?, 'Business user is valid without a user'
    assert_includes business_user.errors[:user], "must exist"
  end

  test 'should save business user with user' do
    business_user = business_users(:one)
    business_user.user = users(:one)
    assert business_user.valid?, 'Business user is valid with user'
    assert_equal business_user.user, users(:one)
  end

  test 'should not save business user without business' do
    business_user = BusinessUser.new
    assert_not business_user.valid?, 'Business user is valid without a business'
    assert_includes business_user.errors[:business], "must exist"
  end

  test 'should save business user with business' do
    business_user = business_users(:one)
    business_user.business = businesses(:one)
    assert business_user.valid?, 'Business user is valid with business'
    assert_equal business_user.business, businesses(:one)
  end

  test 'should not save business user without role' do
    business_user = BusinessUser.new
    assert_not business_user.valid?, 'Business user is valid without a role'
    assert_includes business_user.errors[:role], "can't be blank"
  end

  test 'should save business user with role' do
    business_user = business_users(:one)
    business_user.role = 'admin'
    assert business_user.valid?, 'Business user is valid with role'
    assert_equal business_user.role, 'admin'
  end

  test 'should not save business user with invalid role' do
    business_user = business_users(:one)
    business_user.role = 'invalid'
    assert_not business_user.valid?, 'Business user is valid with invalid role'
    assert_includes business_user.errors[:role], "is not included in the list"
  end

  test 'should not save business user with duplicate user and business' do
    business_user1 = business_users(:one)
    business_user1.user = users(:one)
    business_user1.business = businesses(:one)
    business_user1.save

    business_user2 = BusinessUser.new(user: users(:one), business: businesses(:one), role: 'admin')
    assert business_user1.valid?, 'Business user1 should be valid'
    assert_not business_user2.valid?, 'Business user2 should not be valid due to duplicate user and business'
  end
end
