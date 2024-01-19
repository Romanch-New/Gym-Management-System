# frozen_string_literal: true

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
    business.admin = users(:one)
    assert business.valid?, 'Business is valid with name'
    assert_equal business.name, 'test1'
  end

  test 'should not save business without business type' do
    business = Business.new(name: 'Test', admin: users(:one), business_type: nil)
    assert_not business.valid?, 'Business is valid without a type'
    assert_includes business.errors[:business_type], "can't be blank"
  end

  test 'should save business with business type' do
    business = businesses(:one)
    business.name = 'test2'
    assert business.valid?, 'Business is valid with business_type'
    assert_equal business.business_type, 'personal'
  end

  test 'should not save business without user' do
    business = Business.new(name: 'Test', business_type: 1)
    assert_not business.valid?, 'Business is valid without a user'
    assert_includes business.errors[:admin], 'must exist'
  end

  test 'should save business with user' do
    business = businesses(:one)
    business.name = 'test3'
    assert business.valid?, 'Business is valid with user'
    assert_equal business.admin, users(:one)
  end

  test 'should not save business with duplicate name' do
    business1 = businesses(:one)
    business1.admin = users(:one)
    business1.name = 'test4'
    business1.save
    business2 = Business.new(name: 'test4', business_type: 1, admin: users(:one))
    assert business1.valid?, 'Business is valid with name'
    assert_not business2.valid?, 'Business is valid with duplicate name'
  end

  test 'should only save business if user is admin' do
    business = businesses(:one)
    business.admin = users(:one)
    business.name = 'test5'
    assert business.valid?, 'Business is valid with admin user'
  end

  test 'should not save business if user is not admin' do
    business = businesses(:one)
    business.name = 'test6'
    business.admin = users(:two)
    assert_not business.valid?, 'Business is valid with non-admin user'
    assert_includes business.errors[:admin], 'must be an admin'
  end
end
