# frozen_string_literal: true

# ## Schema Information
#
# Table name: `businesses`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `bigint`           | `not null, primary key`
# **`business_type`**  | `integer`          |
# **`name`**           | `string`           |
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
# **`user_id`**        | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_businesses_on_name` (_unique_):
#     * **`name`**
# * `index_businesses_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  fixtures :businesses, :users

  test 'should not save business without name' do
    business = Business.new
    assert_not business.valid?, 'Business is valid without a name'
    assert_includes business.errors[:name], "can't be blank"
  end

  test 'should save business with name' do
    business = businesses(:one)
    business.name = 'test1'
    business.creator = users(:one)
    assert business.valid?, 'Business is valid with name'
    assert_equal business.name, 'test1'
  end

  test 'should not save business without business type' do
    business = Business.new(name: 'Test', creator: users(:one), business_type: nil)
    assert_not business.valid?, 'Business is valid without a type'
    assert_includes business.errors[:business_type], "can't be blank"
  end

  test 'should save business with business type' do
    business = businesses(:one)
    business.name = 'test2'
    assert business.valid?, 'Business is valid with business_type'
    assert_equal business.business_type, 'personal'
  end

  test 'should not save business without creator' do
    business = Business.new(name: 'Test', business_type: 1)
    assert_not business.valid?, 'Business is valid without a creator'
    assert_includes business.errors[:creator], 'must be present and must be an admin'
  end

  test 'should save business with user' do
    business = businesses(:one)
    business.name = 'test3'
    assert business.valid?, 'Business is valid with user'
    assert_equal business.creator, users(:one)
  end

  test 'should not save business with duplicate name' do
    business1 = businesses(:one)
    business1.creator = users(:one)
    business1.name = 'UniqueBusinessName'
    business1.save

    business2 = Business.new(name: 'UniqueBusinessName', business_type: 1, creator: users(:one))
    assert business1.valid?, 'Business1 should be valid'
    assert_not business2.valid?, 'Business2 should not be valid due to duplicate name'
  end


  test 'should only save business if user is creator' do
    business = businesses(:one)
    business.creator = users(:one)
    business.name = 'test5'
    assert business.valid?, 'Business is valid with creator user'
  end
end
